#!/bin/bash

# 配置用户名和邮箱
GIT_USERNAME="xWenChen"  # 替换为你的用户名
GIT_EMAIL="zhangvc@foxmail.com"  # 替换为你的邮箱

# ANSI 转义码，进行文本高亮。
RED="\033[1;31m"  # 红色
GREEN="\033[1;32m"  # 绿色
YELLOW="\033[1;33m"  # 黄色
BLUE="\033[1;34m"  # 蓝色
PINK="\033[1;35m"  # 粉色
RESET="\033[0m"     # 重置颜色

# 检查 SSH 密钥文件
KEY_FILE="$HOME/.ssh/id_ed25519"
PUB_KEY_FILE="$HOME/.ssh/id_ed25519.pub"
if [ ! -f "$KEY_FILE" ]; then
    echo -e "\nED25519 SSH 密钥文件未找到，使用 ${GREEN}(userName=$GIT_USERNAME, email=$GIT_EMAIL)${RESET} 进行配置..."

    # 配置 Git 用户名和邮箱
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_EMAIL"

    # 生成 RSA 密钥
    echo -e "\n使用 ed25519 加密生成密钥文件，文件的路径为 ${GREEN}$KEY_FILE${RESET} \n"
    ssh-keygen -t ed25519 -C "$GIT_EMAIL"

    # 输出生成的密钥文件内容
    echo -e "\n使用 ed25519 加密生成密钥文件成功，公钥文件的路径为 ${GREEN}$PUB_KEY_FILE${RESET} \n"
else
    echo -e "\ned25519 密钥文件已存在，路径为 ${GREEN}$PUB_KEY_FILE${RESET} \n"
fi

# 输出公钥内容
cat "$PUB_KEY_FILE"
echo -e "\n将密钥配置到 git 远端后，请执行 ${GREEN}ssh -T git@github.com${RESET} 命令查看链接是否生效。"
