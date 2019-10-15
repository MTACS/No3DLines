ARCHS = arm64 arm64e

DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = No3DLines
No3DLines_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
