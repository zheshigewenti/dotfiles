# --- 基础设置 ---
bindkey -v  # 开启 Vi 模式

# --- 历史记录优化 ---
HISTSIZE=10000
SAVEHIST=10000  # 解决原本 100 行限制导致命令丢失的问题 
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS  # 不记录重复的命令
# --- 自动补全与建议 ---
# 加载 zsh-autosuggestions 
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# 增强补全功能
autoload -Uz compinit && compinit 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # 大小写不敏感匹配 
zstyle ':completion:*' menu select  # 开启补全菜单选择

# --- Git 分支提示 ---
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p' 
}
setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{normal}%#%f '

# --- 环境变量与别名 ---
export EDITOR=nvim  # 默认编辑器 
export VISUAL=nvim
export LANG=zh_CN.UTF-8 

alias ls='ls --color'
alias vi='nvim'
alias v='nvim'
alias f='lf'
alias n='neofetch'
alias reboot='sudo reboot'

# --- 代理控制函数 ---
# 使用函数封装，解决原本代理无法便捷关闭的问题
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

# 默认开启代理
proxy_on

# --- 插件与路径 ---
source ~/.zsh/z/z.sh
export PATH="$HOME/.local/bin:$PATH"

#homebrew国内源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_INSTALL_FROM_API=1
