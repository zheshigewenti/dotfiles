bindkey -e
xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 0

# TMUX
# if [[ -z "$TMUX" ]] ;then
#     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#     if [[ -z "$ID" ]] ;then # if not available create a new one

#     else
#         tmux attach-session -t "$ID" # if available attach to it
#     fi
# fi
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
{branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 
if [[ $branch == "" ]]
then : else echo "($branch) " 
fi}

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

source ~/.zsh/z/z.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
