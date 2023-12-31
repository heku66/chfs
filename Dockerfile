# 使用 Alpine 作为基础镜像
FROM alpine:latest as builder

# 设置工作目录
WORKDIR /app
# 安装 wget 和 unzip 工具
RUN apk --no-cache add wget unzip
# 复制外部脚本到工作目录
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh && ./entrypoint.sh && rm -f ./entrypoint.sh

# 最终阶段，定义运行时行为
FROM alpine:latest
RUN apk --no-cache add tzdata
# 设置工作目录
WORKDIR /app

# 从构建阶段复制文件
COPY --from=builder /app .
COPY chfs.ini .

EXPOSE 80
# RUN chmod +x chfs
CMD ["./chfs","-file=chfs.ini"]
