#!/bin/sh

ARCH=$(uname -m)

echo "Current architecture: $ARCH"

if [ "$ARCH" = "x86_64" ]; then
  wget https://example.com/path/to/app-x86_64.zip -O app.zip
else
  wget https://example.com/path/to/app-arm64.zip -O app.zip
fi

unzip app.zip
rm app.zip

chmod +x app

./app
