BOARD_HAVE_BLUETOOTH := true
{{#hsu}}
BOARD_HAVE_BLUETOOTH_RTK := true
BOARD_HAVE_BLUETOOTH_RTK_COEX := true
BLUETOOTH_BLUEDROID_RTK := true
BLUETOOTH_HCI_USE_RTK_H5 := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/common/bluetooth/rtl8723bs/
{{/hsu}}
{{^hsu}}
BOARD_HAVE_BLUETOOTH_LINUX := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/common/bluetooth/bcm43241/
{{/hsu}}
DEVICE_PACKAGE_OVERLAYS += device/intel/common/bluetooth/overlay-bt-pan
DEVICE_PACKAGE_OVERLAYS += device/intel/common/bluetooth/overlay-hid-kb
BOARD_SEPOLICY_DIRS += device/intel/sepolicy/bluetooth/common \
                       device/intel/sepolicy/bluetooth/rtl8723bs

