ARDUINO_PATH = $(CURDIR)/../builder
SKETCH       = $(CURDIR)/src/ESPEasy.ino
TARGET_DIR   = $(CURDIR)/build-esp8266

all:
	@mkdir -p $(TARGET_DIR)
	$(ARDUINO_PATH)/arduino-builder -compile \
	-hardware "$(ARDUINO_PATH)/hardware" \
	-tools "$(ARDUINO_PATH)/tools" \
	-libraries $(CURDIR)/lib \
    -libraries $(CURDIR)/../lib \
	-fqbn=esp8266com:esp8266:generic:CpuFrequency=80,FlashFreq=40,FlashMode=DIO,UploadSpeed=115200,FlashSize=4M1M,ResetMethod=none,Debug=Serial \
	-ide-version=10606 \
	-build-path "$(TARGET_DIR)" \
	-warnings=none \
	-prefs=build.warn_data_percentage=75 \
	-verbose "$(SKETCH)"

clean:
	rm -rf $(TARGET_DIR)

