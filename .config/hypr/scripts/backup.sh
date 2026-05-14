#!/bin/bash

# エラーが起きたらそこでスクリプトを止めるおまじない
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "バックアップを開始するね！"

# コピー先のディレクトリ構造を作成
mkdir -p "$DOTFILES_DIR/.config"

# 設定ファイルのコピー（全部 $HOME に変更して汎用性アップ！）
cp -r "$HOME/.config/hypr" "$DOTFILES_DIR/.config/"
cp -r "$HOME/.config/wezterm" "$DOTFILES_DIR/.config/"
cp -r "$HOME/.config/xdg-desktop-portal" "$DOTFILES_DIR/.config/"
cp -r "$HOME/.config/xdg-desktop-portal-termfilechooser" "$DOTFILES_DIR/.config/"
cp "$HOME/.bashrc" "$DOTFILES_DIR/"

# 📦 パッケージリストのバックアップ
echo "インストールされてるパッケージのリストを作ってるよ..."
# 公式リポジトリからインストールしたパッケージ
pacman -Qqen >"$DOTFILES_DIR/pkglist_repo.txt"
# AURからインストールしたパッケージ
pacman -Qqem >"$DOTFILES_DIR/pkglist_aur.txt"

# Gitの処理
cd "$DOTFILES_DIR" || exit
git add .

# 変更がある場合だけコミットする
if ! git diff --staged --quiet; then
  git commit -m "Backup: $(date +'%Y-%m-%d %H:%M:%S')"
else
  echo "新しくコミットする変更はないみたい！"
fi

# コミットの有無に関わらず、未PushのものがあるかもしれないからPushは実行する
echo "GitHubにPushするね..."
git push origin main

echo "GitへのPushが完了したよ！お疲れ様！"
