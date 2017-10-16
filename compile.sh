BUILDERVERSION=1.3.25
ESPSDKVERSION=2.4.0-rc2
ESPEASYVERSION=v2.0.0-dev12
LIB_SOFTWARESERIALVERSION=3.2.3
if [ ! -e builder ]; then
  mkdir builder; cd builder
  wget https://github.com/arduino/arduino-builder/releases/download/$BUILDERVERSION/arduino-builder-linux64-$BUILDERVERSION.tar.bz2
  tar xf arduino-builder-linux64-$BUILDERVERSION.tar.bz2
  rm arduino-builder-linux64-$BUILDERVERSION.tar.bz2
  cd ..
fi
if [ ! -e builder/hardware/esp8266com ]; then
  mkdir builder/hardware/esp8266com
  git clone https://github.com/esp8266/Arduino.git builder/hardware/esp8266com/esp8266
  pushd builder/hardware/esp8266com/esp8266
  git checkout $ESPSDKVERSION
  popd
  pushd builder/hardware/esp8266com/esp8266/tools
  ./get.py
  popd
fi
if [ ! -e ESPEasy ]; then
  git clone https://github.com/letscontrolit/ESPEasy.git
  pushd ESPEasy
  git checkout $ESPEASYVERSION
  popd
fi
if [ ! -e lib/SoftwareSerial ]; then
  mkdir -p lib
  git clone https://github.com/plerup/espsoftwareserial.git lib/SoftwareSerial
  pushd lib/SoftwareSerial
  git checkout $LIB_SOFTWARESERIALVERSION
  popd
fi
cp Makefile.tpl ESPEasy/Makefile
cd ESPEasy
make clean all
