# Stage 1: Python 环境构建阶段
FROM python:3.11.8-alpine AS python-builder
# 升级 pip、setuptools、wheel
RUN python -m pip install --upgrade --no-cache-dir pip setuptools wheel

# Stage 2: Node 环境构建阶段
FROM node:21.7.3-alpine AS node-builder
# 此阶段可加入 Node 相关构建任务，例如 npm install

# 最终镜像阶段：基于纯净的 Alpine 镜像
FROM alpine:3.19

# 从 python-builder 阶段复制 Python 环境
COPY --from=python-builder /usr/local /usr/local
# 从 node-builder 阶段复制 Node 环境
COPY --from=node-builder /usr/local /usr/local

# 安装运行时必须的依赖库（极简）
RUN apk add --no-cache \
        bash \
        dcron \
        tzdata \
        libstdc++ \
        ca-certificates \
        libffi \
        openssl \
        readline \
        zlib \
        expat \
        bzip2 \
        sqlite-libs \
        git \
        wget \
    && ln -sf /usr/local/bin/python3 /usr/local/bin/python \
    && ln -sf /usr/local/bin/pip3 /usr/local/bin/pip \
    && rm -rf /var/cache/apk/*

# 设置工作目录和创建必要目录
WORKDIR /app

# 将 docker-entrypoint.sh 脚本复制到镜像中并赋予执行权限
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# 可选：添加测试脚本
# RUN echo "import sys\nprint('Python脚本执行成功 - ' + sys.version)" > /app/scripts/task.py
# RUN echo "console.log('Node脚本执行成功 - ' + process.version + ' - ' + new Date().toISOString());" > /app/scripts/daily-job.js

# 设置容器启动入口为 docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]