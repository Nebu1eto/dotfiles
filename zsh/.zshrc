# load starship
eval "$(starship init zsh)"

# initialize zplugin
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# load external shell plugins
zplugin light simnalamburt/cgitc
zplugin light simnalamburt/zsh-expand-all
zplugin light zsh-users/zsh-completions
if is-at-least 5.3; then
  zplugin ice silent wait'1' atload'_zsh_autosuggest_start'
fi
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin light zdharma/history-search-multi-word
zplugin light zsh-users/zsh-history-substring-search
zplugin light djui/alias-tips

# compinit
autoload -Uz compinit
compinit
zplugin cdreplay

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# define environmental variables
export PATH=$PATH:/usr/local/bin:~/.cargo/bin:/usr/local/opt/go/libexec/bin:/usr/local/opt/coreutils/libexec/gnubin
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export GOPATH=$HOME/go
export NVM_DIR=~/.nvm

# define some aliases.
alias g='git'
alias vi="vim"
alias ls="exa --long -aRT -L=1 --git -h"
alias cat="bat"
alias hist="history | tail -n"

# sensible aliases
alias ...='cd ./..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias ........='cd ../../../..'
alias ..........='cd ../../../../..'

# initialize external modules
eval $(thefuck --alias)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
