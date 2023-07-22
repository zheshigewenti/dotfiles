bindkey -e
xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 0

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Case-insensitive matching
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# history
SAVEHIST=200  # Save most-recent 20 lines
HISTFILE=~/.zsh_history

# git branch prompt

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
 
setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{normal}%#%f '



# alias
# alias grep='grep --color=auto'
alias ls='ls --color'
alias vim='nvim'
alias n='neofetch'
alias reboot='sudo reboot'
alias j='joshuto'
alias t='thunar'
export EDITOR=nvim

# color
export LS_COLORS="$LS_COLORS::ln=36:di=35:ex=32:*.tar=0;31:*.gz=0;31:*.zip=0;31:*.xz=0;31:*.jpg=0;33:*.png=0;33:*.jpeg=0;33"

# proxy
export http_proxy=http://127.0.0.1:7890/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

# fcitx
export GTK_TM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export SDL_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"

# lang
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export LC_CTYPE=en_US.UTF-8

source ~/.zsh/z/z.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
