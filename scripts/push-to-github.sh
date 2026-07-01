#!/bin/bash
# 首次使用前：在 GitHub 创建空仓库 https://github.com/new
# 仓库名：chemistry-wiki，不要勾选 README（本地已有）

set -e
cd "$(dirname "$0")/.."

REMOTE="${1:-git@github.com:kiss3735707/chemistry-wiki.git}"

if ! git remote get-url origin &>/dev/null; then
  git remote add origin "$REMOTE"
  echo "已添加 remote: $REMOTE"
fi

git push -u origin main
echo "推送完成。其他设备可 clone: $REMOTE"
