#!/bin/bash

# 必须以 root 身份运行
USER_LIST="/home/jialai/adduser/users.txt"
MOUNT_BASE="/mnt/hdd1"

while IFS=',' read -r username pubkey
do
    echo "正在添加用户：$username"

    # 创建用户
    useradd -m "$username"

    # 配置 .ssh
    USER_HOME="/home/$username"
    SSH_DIR="$USER_HOME/.ssh"
    AUTH_KEYS="$SSH_DIR/authorized_keys"

    mkdir -p "$SSH_DIR"
    touch "$AUTH_KEYS"
    chmod 700 "$SSH_DIR"
    chmod 600 "$AUTH_KEYS"
    chown -R "$username:$username" "$SSH_DIR"

    # 写入公钥
    echo "$pubkey" >> "$AUTH_KEYS"

    # 配置挂载目录
    USER_MOUNT_DIR="$MOUNT_BASE/$username"
    mkdir -p "$USER_MOUNT_DIR"
    chown -R "$username:$username" "$USER_MOUNT_DIR"

    echo "用户 $username 添加成功"
    echo "--------------------------"
done < "$USER_LIST"
