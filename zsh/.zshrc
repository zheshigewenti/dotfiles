# --- 历史记录优化 ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY           # 多个标签页共享历史，不再互相覆盖
setopt APPEND_HISTORY          # 立即追加写入
setopt HIST_IGNORE_ALL_DUPS    # 全局去重，只保留最近一次
setopt HIST_REDUCE_BLANKS      # 去掉命令里多余的空格

# --- 自动补全 ---
# zstyle 必须在 compinit 之前设置
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # 大小写不敏感匹配
zstyle ':completion:*' menu select                       # 开启补全菜单选择

zmodload zsh/complist   # menu select 依赖该模块
autoload -Uz compinit
# 每天重建一次补全缓存，其余时间用 -C 跳过安全检查（省 ~20ms/次）
_zstamp="${ZDOTDIR:-$HOME}/.zcompdump.stamp"
if [[ -f "$_zstamp" ]] && (( $(date +%s) - $(stat -f %m "$_zstamp") < 86400 )); then
  compinit -C
else
  compinit
  touch "$_zstamp"
fi
unset _zstamp

# --- 自动建议 ---
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# --- mdfind 快速打开 ---
v() {
  vi "$(mdfind -name "$1" | head -n 1)"
}

# --- Git 分支提示 ---
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
setopt PROMPT_SUBST
export PROMPT='%F{8}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{default}%#%f '

# --- 环境变量与别名 ---
export EDITOR=nvim
export VISUAL=nvim
export LANG=zh_CN.UTF-8

alias ls='ls --color'
alias vi='nvim'
alias lg='lazygit'
alias f='fastfetch'     # 原来被 lf 占用，现在归 fastfetch
alias reboot='sudo reboot'

# --- 插件与路径 ---
typeset -U path
path=("$HOME/.local/bin" $path)
export PATH

# homebrew 国内源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_INSTALL_FROM_API=1

# --- bun ---
# bun 本体由 Homebrew 安装；~/.bun/bin 只用于 bun 全局包的可执行文件，
# 放在 PATH 末尾，避免旧的 bun 二进制遮住 /opt/homebrew/bin/bun。
export BUN_INSTALL="$HOME/.bun"
typeset -U path
path+=("$BUN_INSTALL/bin")
export PATH

# --- opencode: 不带参数时自动续上一次会话 ---
opencode() {
  if [ $# -eq 0 ]; then
    command opencode --continue
  else
    command opencode "$@"
  fi
}

# --- 新终端默认切到英文输入法 ---
if [[ -o interactive ]] && [ -x "$HOME/.local/bin/im" ]; then
  "$HOME/.local/bin/im" en >/dev/null 2>&1
fi
