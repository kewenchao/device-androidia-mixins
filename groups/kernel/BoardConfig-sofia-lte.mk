BOARD_KERNEL_CMDLINE += \
	idle=halt \
	debug \
	nolapic_pm \
	apic=sofia \
	cma={{{cma_size}}}

ifneq (,$(filter eng userdebug,$(TARGET_BUILD_VARIANT)))
BOARD_KERNEL_CMDLINE += \
	console=ttyS0,115200n8 \
	earlyprintk={{{earlyprintk}}}
endif # TARGET_BUILD_VARIANT is eng, userdebug

{{#lapic_timer}}
BOARD_KERNEL_CMDLINE += \
    nolapic_timer \
    x86_intel_xgold_timer=soctimer_only
{{/lapic_timer}}

# Device Tree Blob file name:
BOARD_DTB_FILE ?= {{{board_dtb}}}
