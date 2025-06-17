#!/bin/bash
set -e

# ==== 修改下面这两个变量 ====
USERNAME="heyingzhi2"
PUBKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINAuHb9kQc32h1eUp3cgQ6RJIlBVZt84EJKI0aFieHzn heyingzhi@u.nus.edu"

# ==== 开始操作 ====
echo "🔧 开始添加用户 $USERNAME ..."

# 检查用户是否存在
if id "$USERNAME" &>/dev/null; then
    echo "⚠️ 用户 $USERNAME 已存在，跳过 useradd"
else
    useradd -m "$USERNAME"
    echo "✅ 用户 $USERNAME 创建成功"
fi

# 创建 .ssh 和 authorized_keys
USER_HOME="/home/$USERNAME"
SSH_DIR="$USER_HOME/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

mkdir -p "$SSH_DIR"
echo "$PUBKEY" > "$AUTHORIZED_KEYS"
chmod 700 "$SSH_DIR"
chmod 600 "$AUTHORIZED_KEYS"
chown -R "$USERNAME:$USERNAME" "$SSH_DIR"
echo "✅ SSH 公钥设置完成"

# 创建挂载目录
MOUNT_DIR="/mnt/hdd1/$USERNAME"
mkdir -p "$MOUNT_DIR"
chown -R "$USERNAME:$USERNAME" "$MOUNT_DIR"
echo "✅ 挂载目录已创建：$MOUNT_DIR"

echo "🎉 用户 $USERNAME 设置完毕"
