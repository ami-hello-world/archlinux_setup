#!/bin/bash

# バックアップ先のディレクトリ
DOTFILES_DIR="$HOME/dotfiles"

echo "たつと、バックアップを開始するね！"

# コピー先のディレクトリ構造を作成
mkdir -p "$DOTFILES_DIR/.config"

# フォルダとファイルのコピー
# (もし上で提案したwaybarなども追加するなら、ここに追記してね)
cp -r /home/ami/.config/hypr "$DOTFILES_DIR/.config/"
cp -r /home/ami/.config/wezterm "$DOTFILES_DIR/.config/"
cp -r /home/ami/.config/xdg-desktop-portal "$DOTFILES_DIR/.config/"
cp -r /home/ami/.config/xdg-desktop-portal-termfilechooser "$DOTFILES_DIR/.config/"
cp /home/ami/.bashrc "$DOTFILES_DIR/"

# Gitの処理
cd "$DOTFILES_DIR" || exit
git add .
git commit -m "Backup: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main # ブランチ名がmasterの場合はmasterに変えてね

echo "GitへのPushが完了したよ！お疲れ様！"
