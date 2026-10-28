# 登录 shell 也需要 ~/.local/bin（非交互登录时不会读 .zshrc）
typeset -U path
path=("$HOME/.local/bin" $path)
export PATH
