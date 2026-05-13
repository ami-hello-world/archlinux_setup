#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
# ~/.bashrc の末尾に追記
fj() {
  source ~/.config/hypr/scripts/fzf-jump.sh
}
eval "$(zoxide init bash)"
