#!/bin/sh
set -e

echo "Container initialization started..."

# 创建所有必要的目录
mkdir -p /app/scripts /app/config /app/shell /var/log/cron

# 如果 /app/config/cron.list 文件不存在，则创建该文件
[ ! -f /app/config/cron.list ] && touch /app/config/cron.list

# 如果 /app/shell/task.sh 文件不存在，则使用 wget 下载 task.sh 脚本
if [ ! -f /app/shell/task.sh ]; then
    echo "Downloading task.sh using wget..."

    # 如果 wget 不存在，则通过 apk 安装 wget
    if ! command -v wget > /dev/null 2>&1; then
        echo "wget not found, installing wget via apk..."
        apk update && apk add wget
    fi

    wget -O /app/shell/task.sh https://raw.githubusercontent.com/MrNanko/docker-templates/refs/heads/main/npc/task.sh
fi

# 判断 /app/shell/task.sh 是否存在，如果存在，则设置可执行权限并创建软链接到 /usr/local/bin/task
if [ -f /app/shell/task.sh ]; then
    chmod +x /app/shell/task.sh
    ln -sf /app/shell/task.sh /usr/local/bin/task
fi

echo "Initialization complete. Starting cron daemon..."
exec crond -f -l 4