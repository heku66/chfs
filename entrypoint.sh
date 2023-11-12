#!/bin/sh

ARCH=$(uname -m)

echo "Current architecture: $ARCH"

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL="http://iscute.cn/tar/chfs/3.1/chfs-linux-amd64-3.1.zip"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL="http://iscute.cn/tar/chfs/3.1/chfs-linux-arm64-3.1.zip"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

# 下载压缩文件
wget "$DOWNLOAD_URL" -O app.zip

# 解压文件并重命名
unzip app.zip
mv chfs-* chfs

# 清理工作目录
rm app.zip
chmod +x chfs
