gptimage_size ?= {{{size}}}

raw_config := none
raw_factory := none
tos_bin := none

.PHONY: none
none: ;

.PHONY: $(INSTALLED_CONFIGIMAGE_TARGET).raw
$(INSTALLED_CONFIGIMAGE_TARGET).raw: $(INSTALLED_CONFIGIMAGE_TARGET) $(SIMG2IMG)
	$(SIMG2IMG) $< $@

.PHONY: $(INSTALLED_FACTORYIMAGE_TARGET).raw
$(INSTALLED_FACTORYIMAGE_TARGET).raw: $(INSTALLED_FACTORYIMAGE_TARGET) $(SIMG2IMG)
	$(SIMG2IMG) $< $@

ifdef INSTALLED_CONFIGIMAGE_TARGET
raw_config := $(INSTALLED_CONFIGIMAGE_TARGET).raw
endif

ifdef INSTALLED_FACTORYIMAGE_TARGET
raw_factory := $(INSTALLED_FACTORYIMAGE_TARGET).raw
endif

.PHONY: $(GPTIMAGE_BIN)
ifeq ($(strip $(TARGET_USE_TRUSTY)),true)
$(GPTIMAGE_BIN): tosimage
tos_bin = $(INSTALLED_TOS_IMAGE_TARGET)
endif

$(GPTIMAGE_BIN): \
	bootloader \
	bootimage \
	recoveryimage \
	systemimage \
	cacheimage \
    {{#vendor-partition}}
	vendorimage \
    {{/vendor-partition}}
	$(SIMG2IMG) \
	$(raw_config) \
	$(raw_factory)

	$(hide) rm -f $(INSTALLED_SYSTEMIMAGE).raw
	$(hide) rm -f $(INSTALLED_USERDATAIMAGE_TARGET).raw
	$(hide) rm -f $(INSTALLED_CACHEIMAGE_TARGET).raw

	$(MAKE_EXT4FS) \
		-l $(BOARD_USERDATAIMAGE_PARTITION_SIZE) -L android_data \
		$(PRODUCT_OUT)/userdata.dummy

	$(SIMG2IMG) $(INSTALLED_SYSTEMIMAGE) $(INSTALLED_SYSTEMIMAGE).raw
	$(SIMG2IMG) $(INSTALLED_CACHEIMAGE_TARGET) $(INSTALLED_CACHEIMAGE_TARGET).raw
    {{#vendor-partition}}
	$(SIMG2IMG) $(INSTALLED_VENDORIMAGE_TARGET) $(INSTALLED_VENDORIMAGE_TARGET).raw
    {{/vendor-partition}}

	device/intel/build/create_gpt_image.py \
		--create $@ \
		--block $(BOARD_FLASH_BLOCK_SIZE) \
		--table $(BOARD_GPT_INI) \
		--size $(gptimage_size) \
		--bootloader $(bootloader_bin) \
		--bootloader2 $(bootloader_bin) \
		--tos $(tos_bin) \
		--boot $(INSTALLED_BOOTIMAGE_TARGET) \
		--recovery $(INSTALLED_RECOVERYIMAGE_TARGET) \
		--system $(INSTALLED_SYSTEMIMAGE).raw \
        {{#vendor-partition}}
		--vendor $(INSTALLED_VENDORIMAGE_TARGET).raw \
        {{/vendor-partition}}
		--data $(PRODUCT_OUT)/userdata.dummy \
		--cache $(INSTALLED_CACHEIMAGE_TARGET).raw \
		--config $(raw_config) \
		--factory $(raw_factory)

.PHONY: gptimage
gptimage: $(GPTIMAGE_BIN)

