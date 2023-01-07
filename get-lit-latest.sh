#!/bin/sh

LUVI_ARCH=`uname -s`_`uname -m`
LUVI_URL="https://github.com/luvit/luvi/releases/latest/download/luvi-regular-$LUVI_ARCH"
LIT_URL="https://github.com/wbx/lit/releases/latest/download/lit.zip"

# Download Files
echo "Downloading $LUVI_URL to luvi"
curl -L -f -o luvi $LUVI_URL
chmod +x luvi

echo "Downloading $LIT_URL to lit.zip"
curl -L -f -o lit.zip $LIT_URL

# Create lit using lit
./luvi lit.zip -- make lit.zip lit luvi
# Cleanup
rm -f lit.zip
# Create luvit using lit
./lit make github://luvit/luvit luvit luvi
