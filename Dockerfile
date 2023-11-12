# 使用 Alpine 作为基础镜像
FROM alpine:latest as builder

# 设置工作目录
WORKDIR /app

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

# 进行解压等操作，具体取决于你的软件包
RUN tar -xzvf software-x86_64.tar.gz && \
    tar -xzvf software-arm64.tar.gz
