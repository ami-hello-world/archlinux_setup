# ~/.config/hypr/scripts/fj-core.sh
# 検索して変数に入れる
TARGET=$(fd -H . ~ | fzf --prompt="Search> ")

if [ -n "$TARGET" ]; then
  if [ -d "$TARGET" ]; then
    DIR="$TARGET"
  else
    DIR=$(dirname "$TARGET")
  fi

  # 移動する。sourceで読み込まれることを想定し return を使う
  cd "$DIR" || return

  clear
  echo -e "\e[1;32mJumped to: $PWD\e[0m"
  echo ""
  ls -la
fi
