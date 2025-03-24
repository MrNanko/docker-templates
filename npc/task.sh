#!/bin/bash

# 加载环境变量
source /app/config/env.sh

# 检查参数是否传入
if [ -z "$1" ]; then
    echo "请输入要执行的脚本路径，例如：./task.sh ./demo.py"
    exit 1
fi

original_script="$1"

# 检查文件是否存在
if [ ! -f "$original_script" ]; then
    echo "文件不存在：$original_script"
    exit 1
fi

# 获取文件名和后缀
script_name=$(basename "$original_script")
script_base="${script_name%.*}"
extension="${script_name##*.}"

# 设置目标路径
scripts_dir="/app/run"
target_script="$scripts_dir/$script_name"

# 创建目标目录（如不存在）
mkdir -p "$scripts_dir"

# 如果目标已存在，进行 MD5 比较
if [ -f "$target_script" ]; then
    src_md5=$(md5sum "$original_script" | awk '{print $1}')
    dst_md5=$(md5sum "$target_script" | awk '{print $1}')

    if [ "$src_md5" == "$dst_md5" ]; then
        echo "脚本未发生变化，跳过覆盖：$target_script"
    else
        echo "脚本已更新，覆盖原文件：$target_script"
        cp -f "$original_script" "$target_script"
    fi
else
    echo "脚本不存在，首次复制到：$target_script"
    cp "$original_script" "$target_script"
fi

# 设置日志路径
log_folder="/app/log/$script_base"
mkdir -p "$log_folder"
log_file="$log_folder/$(date '+%Y-%m-%d-%H-%M-%S').log"

# 根据扩展名执行对应脚本
case "$extension" in
  py)
    echo "执行 Python 脚本: $target_script"
    python3 "$target_script" 2>&1 | tee "$log_file"
    ;;
  js)
    echo "执行 Node.js 脚本: $target_script"
    node "$target_script" 2>&1 | tee "$log_file"
    ;;
  *)
    echo "不支持的脚本类型: .$extension"
    exit 1
    ;;
esac

# 安装定时任务（如果有 cron.list）
if [ -f /app/config/cron.list ]; then
    crontab /app/config/cron.list
else
    echo "未找到 /app/config/cron.list，跳过安装 crontab"
fi