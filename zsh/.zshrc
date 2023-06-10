bindkey -e

#zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Case-insensitive matching
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#history
SAVEHIST=20  # Save most-recent 20 lines
HISTFILE=~/.zsh_history

# git branch prompt
function git_branch()
{
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ $branch == "" ]]
    then
        :
    else
			echo "($branch) "
    fi
}
git_prompt='$(git_branch)'
PS1='%n%# '%F{#A7C080}$git_prompt%f

setopt prompt_subst
setopt histreduceblanks
setopt histignorealldups
setopt no_nomatch

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias n='neofetch'
alias reboot='sudo reboot'
alias j='joshuto'
alias t='thunar'

export LS_COLORS=$LS_COLORS:"*.tar=0;31":"*.xz=0;31":"*.gz=0;31":"*.jpg=0;33":"*.png=0;33"
export EDITOR=nvim

#proxy
export http_proxy=http://127.0.0.1:7890/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

#fcitx
export GTK_TM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export SDL_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"

#lang
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export LC_CTYPE=en_US.UTF-8

#fzf
export FZF_DEFAULT_OPTS='--bind ctrl-j:down,ctrl-k:up --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500"'
export FZF_DEFAULT_COMMAND='rg -S --files --hidden'
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='\'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion  使用fd生成搜索列表
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1" 
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}


xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 0
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
