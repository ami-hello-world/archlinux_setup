#!/bin/bash

# エラーが起きたらそこでスクリプトを止めるおまじない
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "バックアップを開始するね！"

# コピー先のディレクトリ構造を作成
mkdir -p "$DOTFILES_DIR/.config"

# 設定ファイルのコピー
cp -r /home/ami/.config/hypr "$DOTFILES_DIR/.config/"
cp -r /home/ami/.config/wezterm "$DOTFILES_DIR/.config/"
cp -r /home/ami/.config/xdg-desktop-portal "$DOTFILES_DIR/.config/"
cp -r /home/ami/.config/xdg-desktop-portal-termfilechooser "$DOTFILES_DIR/.config/"
cp /home/ami/.bashrc "$DOTFILES_DIR/"

# 📦 パッケージリストのバックアップを追加！
echo "インストールされてるパッケージのリストを作ってるよ..."
# 公式リポジトリからインストールしたパッケージ
pacman -Qqen >"$DOTFILES_DIR/pkglist_repo.txt"
# AURからインストールしたパッケージ
pacman -Qqem >"$DOTFILES_DIR/pkglist_aur.txt"

# Gitの処理
cd "$DOTFILES_DIR" || exit
git add .

# 変更がない場合はコミットでエラーになるから、それを回避する処理
if git diff --staged --quiet; then
  echo "変更されたファイルがないみたいだから、今回はここで終わるね！"
  exit 0
fi

git commit -m "Backup: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

echo "GitへのPushが完了したよ！お疲れ様！"
