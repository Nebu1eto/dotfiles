export PATH=/opt/homebrew/bin:/usr/local/bin:~/.local/bin:~/.cargo/bin:$PATH

# load starship
eval "$(starship init zsh)"

# initialize zinit
source ~/.zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# compinit
autoload -Uz compinit
compinit
zinit cdreplay

# load external shell plugins
zinit self-update
zinit light simnalamburt/cgitc
zinit light simnalamburt/zsh-expand-all
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-history-substring-search

if is-at-least 5.3; then
  zinit ice silent wait'1' atload'_zsh_autosuggest_start'
fi

eval "$(zoxide init zsh)"
eval $(thefuck --alias)

# TODO: mise 깔았으니... 빨리 nvm은 지우는걸로
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

# define some aliases.
alias g='git'
alias vi="nvim"
alias vim="nvim"
alias ls="lsd -lFNg --group-dirs=first"
alias cat="bat --number"
alias catp="bat --paging never"
alias catpp="bat --plain --paging never"

# sensible aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

