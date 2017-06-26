######################################################################
# User configuration
######################################################################
# Path to nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader)
NODEMCU-UPLOADER=/Users/gino/Downloads/nodemcu-uploader/nodemcu-uploader.py
# Serial port
PORT=/dev/cu.SLAB_USBtoUART
SPEED=115200

NODEMCU-COMMAND-U=$(NODEMCU-UPLOADER) -b $(SPEED) --start_baud $(SPEED) -p $(PORT) upload

LUA_FILES := \
   init.lua \
   Clock.lua \
   Definitions.lua \
   Ds3231.lua \
   Rtc.lua \
   Web.lua \
   Ldr.lua \
   Settings.lua \
   start.lua \
   Wifi.lua \
   web.html \

# Print usage
usage:
	@echo "make upload_all           to upload all"
	@echo $(TEST)

# Upload all
upload_all: $(LUA_FILES)
	@python $(NODEMCU-COMMAND-U) $(foreach f, $^, $(f))



