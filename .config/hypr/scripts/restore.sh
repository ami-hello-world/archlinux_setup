#!/bin/bash

# エラーが起きたら止める
set -e

# 🚨 root（sudo）での実行を禁止する安全装置
if [ "$EUID" -eq 0 ]; then
  echo "❌ エラー: たつと、このスクリプトは sudo をつけずに実行してね！"
  echo "必要な時だけ自動でパスワードを聞かれるから、一般ユーザーのままで大丈夫だよ。"
  exit 1
fi

DOTFILES_DIR="$HOME/dotfiles"

echo "たつと、環境の復元（リストア）を開始するね！"

# 1. パッケージの復元
echo "📦 まずは公式パッケージをインストールするよ..."
if [ -f "$DOTFILES_DIR/pkglist_repo.txt" ]; then
  # ここでパスワードを聞かれるよ
  sudo pacman -S --needed - <"$DOTFILES_DIR/pkglist_repo.txt"
else
  echo "公式パッケージのリストが見つからないみたい。スキップするね。"
fi

echo "📦 次にAURのパッケージをインストールするよ..."
if ! command -v yay &>/dev/null; then
  echo "yayがインストールされていないみたいだから、先にインストールするね！"
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  # 一般ユーザーとして実行されるから弾かれない！
  makepkg -si --noconfirm
  cd "$DOTFILES_DIR"
fi

if [ -f "$DOTFILES_DIR/pkglist_aur.txt" ]; then
  # yayも一般ユーザーとして実行
  yay -S --needed - <"$DOTFILES_DIR/pkglist_aur.txt"
else
  echo "AURパッケージのリストが見つからないみたい 。スキップするね。"
fi

# 2. 設定ファイルの復元
echo "📂 設定ファイルを元の場所に戻していくね..."
mkdir -p /home/ami/.config

# フォルダごと上書きコピー
cp -r "$DOTFILES_DIR/.config/hypr" /home/ami/.config/
cp -r "$DOTFILES_DIR/.config/wezterm" /home/ami/.config/
cp -r "$DOTFILES_DIR/.config/xdg-desktop-portal" /home/ami/.config/
cp -r "$DOTFILES_DIR/.config/xdg-desktop-portal-termfilechooser" /home/ami/.config/
cp "$DOTFILES_DIR/.bashrc" /home/ami/

echo "✨ 復元がすべて完了したよ！お疲れ様！"
