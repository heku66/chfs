# 使用 Alpine 作为基础镜像
FROM alpine:latest as builder

# 设置工作目录
WORKDIR /app
# 安装 wget 和 unzip 工具
RUN apk --no-cache add wget unzip
# 复制外部脚本到工作目录
COPY entrypoint.sh .

# 运行外部脚本
CMD ["sh", "entrypoint.sh"]

# 最终阶段，定义运行时行为
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 从构建阶段复制文件
COPY --from=builder /app .
COPY chfs.ini .
# 进行解压等操作，具体取决于你的软件包

EXPOSE 80
RUN chmod +x chfs
CMD ["./chfs","-file=chfs.ini"]
------------------------------
FROM alpine:latest
LABEL maintainer="solyhe84"
# 设置工作目录
WORKDIR /app

# 复制 x86_64 平台专用文件
COPY chfs-linux-amd64 chfs
COPY chfs.ini .

EXPOSE 80
RUN chmod +x chfs
CMD ["./chfs","-file=chfs.ini"]
