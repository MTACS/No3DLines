THEOS_DEVICE_IP = 192.168.1.16

TARGET = iphone:clang:13.0:13.0

ARCHS = arm64 arm64e

DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = No3DLines
No3DLines_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
