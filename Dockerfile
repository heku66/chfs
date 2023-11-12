# 使用 Alpine 作为基础镜像
FROM alpine:latest as builder

# 设置工作目录
WORKDIR /app
RUN apk add 
# 下载 x86_64 平台的软件包
RUN wget https://example.com/path/to/software-x86_64.tar.gz -O software-x86_64.tar.gz

# 下载 arm64 平台的软件包
RUN wget https://example.com/path/to/software-arm64.tar.gz -O software-arm64.tar.gz

# 最终阶段，定义运行时行为
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 从构建阶段复制文件
COPY --from=builder /app .
COPY chfs.ini .
# 进行解压等操作，具体取决于你的软件包
RUN tar -xzvf software-x86_64.tar.gz && \
    tar -xzvf software-arm64.tar.gz

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
