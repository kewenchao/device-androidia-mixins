{{^fls_prebuilts}}
BUILD_BOOTCORE_FROM_SRC := true
BUILD_SECVM_FROM_SRC := true
BUILD_VMM_FROM_SRC := true
GEN_VMM_FLS_FILES := true
{{/fls_prebuilts}}
{{#fls_prebuilts}}
BUILD_BOOTCORE_FROM_SRC := false
BUILD_SECVM_FROM_SRC := false
BUILD_VMM_FROM_SRC := false
GEN_VMM_FLS_FILES := false
{{/fls_prebuilts}}
GEN_ANDROID_FLS_FILES := true
MODEM_PLATFORM := {{{modem_platform}}}
MODEM_PROJECTNAME := {{{modem_projectname}}}
MV_CONFIG_BITNESS := {{{bitness}}}
MV_CONFIG_CHIP_VER := {{{mv_config_chip_ver}}}
MODEM_BUILD_ARGUMENTS = INT_STAGE=MEX HW_BASE=XG_ES_2.0 UTA_CLIENT=RPC ASM_DEFS_PLATFORM= CBE_UMTSFW_DEVEL=YES CREATEFLS=NO RMV_FEATURE=FEAT_STT_DECODERS PARTITION_XML_INPUT=${PARTITION_XML_PATH} RAMLAYOUT_XML_INPUT=${RAMLAYOUT_XML_PATH} ADD_SYSTEM_DEFS+=LOLLIPOP_PARTITION

BUILT_MODEM := modem/prebuilt/$(MODEM_PLATFORM)/$(MODEM_PROJECTNAME).ihex

{{^fls_prebuilts}}
NON_IMC_BUILD := true
{{/fls_prebuilts}}
{{#fls_prebuilts}}
NON_IMC_BUILD := false
{{/fls_prebuilts}}
export NON_IMC_BUILD

include device/intel/common/boot/sofia/sofia-base.mk
