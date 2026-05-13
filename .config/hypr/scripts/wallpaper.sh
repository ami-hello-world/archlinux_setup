#!/bin/bash

# 壁紙が保存されているディレクトリ
WALLPAPER_DIR="$HOME/.config/hypr/wallpaper"

# ディレクトリが存在するかチェック
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "ディレクトリが見つからないよ: $WALLPAPER_DIR"
  exit 1
fi

# フォルダ内の画像ファイル（jpg, pngなど）をリストアップしてRofiに渡す
# Rofiで選択されたファイル名を変数に格納
SELECTED_WALLPAPER=$(ls "$WALLPAPER_DIR" | grep -E '\.(jpg|jpeg|png|gif)$' | rofi -dmenu -i -p "🌸 壁紙を選んでね:")

# 選択されたら壁紙を設定
if [ -n "$SELECTED_WALLPAPER" ]; then
  feh --bg-scale "$WALLPAPER_DIR/$SELECTED_WALLPAPER"
  # 通知を出したい場合は下のコメントアウトを外してね（dunstなどが必要）
  # notify-send "壁紙を変更したよ！" "$SELECTED_WALLPAPER"
fi
