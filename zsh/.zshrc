# --- 基础设置 ---
bindkey -v  # 开启 Vi 模式

# --- 历史记录优化 ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS        # 不记录重复的命令
setopt SHARE_HISTORY           # 多个标签页共享历史，不再互相覆盖
setopt APPEND_HISTORY          # 立即追加写入
setopt HIST_IGNORE_ALL_DUPS    # 全局去重，只保留最近一次
setopt HIST_REDUCE_BLANKS      # 去掉命令里多余的空格

# --- 自动补全 ---
# zstyle 必须在 compinit 之前设置
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # 大小写不敏感匹配
zstyle ':completion:*' menu select                       # 开启补全菜单选择

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
export PROMPT='%F{grey}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{normal}%#%f '

# --- 环境变量与别名 ---
export EDITOR=nvim
export VISUAL=nvim
export LANG=zh_CN.UTF-8

alias ls='ls --color'
alias vi='nvim'
alias lg='lazygit'
alias f='fastfetch'     # 原来被 lf 占用，现在归 fastfetch
alias reboot='sudo reboot'

# --- 代理控制 ---
proxy_on() {
    export http_proxy=http://127.0.0.1:7897
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    echo "代理已开启 (Port: 7897)"
}

proxy_off() {
    unset http_proxy https_proxy ftp_proxy rsync_proxy no_proxy
    echo "代理已关闭"
}

# 只有 Clash 真的在监听时才自动开代理，否则 curl/git/brew 会卡在死代理上
if nc -z -G 1 127.0.0.1 7897 >/dev/null 2>&1; then
    proxy_on >/dev/null
fi

# --- 插件与路径 ---
source ~/.zsh/z/z.sh
export PATH="$HOME/.local/bin:$PATH"

# homebrew 国内源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_INSTALL_FROM_API=1

# --- bun ---
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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
