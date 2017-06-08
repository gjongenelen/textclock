######################################################################
# User configuration
######################################################################
# Path to nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader)
NODEMCU-UPLOADER=/Users/gino/Downloads/nodemcu-uploader/nodemcu-uploader.py
# Serial port
PORT=/dev/cu.SLAB_USBtoUART
SPEED=115200

NODEMCU-COMMAND-U=$(NODEMCU-UPLOADER) -b $(SPEED) --start_baud $(SPEED) -p $(PORT) upload
NODEMCU-COMMAND-R=$(NODEMCU-UPLOADER) -b $(SPEED) --start_baud $(SPEED) -p $(PORT) node restart

LUA_FILES := \
   init.lua \
   clock.lua \
   definitions.lua \
   ds3231.lua \
   rtc.lua \
   web.lua \
   wifi.lua \

# Print usage
usage:
	@echo "make upload_all           to upload all"
	@echo $(TEST)

# Upload all
upload_all: $(LUA_FILES)
	@python $(NODEMCU-COMMAND-U) $(foreach f, $^, $(f))

# Restart
restart:
	@python $(NODEMCU-COMMAND-R)

# Log
restart:
	@python $(NODEMCU-COMMAND-R)


