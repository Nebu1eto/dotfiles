# Fig 자동완성을 위한 설정
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh

# define environmental variables
export PATH=/opt/homebrew/bin:/opt/homebrew/opt/python@3.8/bin:/usr/local/bin:~/.local/bin:~/.cargo/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export NVM_DIR=~/.nvm

# load starship
eval "$(starship init zsh)"

# initialize zinit
source ~/.zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load external shell plugins
zinit self-update

zinit light simnalamburt/cgitc
zinit light simnalamburt/zsh-expand-all
# zinit light zsh-users/zsh-completions
if is-at-least 5.3; then
  zinit ice silent wait'1' atload'_zsh_autosuggest_start'
fi
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-history-substring-search
zinit light djui/alias-tips

# compinit
autoload -Uz compinit
compinit
zinit cdreplay

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# define some aliases.
alias g='git'
alias vi="nvim"
alias vim="nvim"
alias lstree="exa --long -aRT --git -h -L=3"
alias cat="bat --plain --paging never "
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

# Fig 자동 완성을 위한 설정 2
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

alias docker_login_iamdt="aws ecr get-login-password --region ap-northeast-2 --profile iamdt | docker login --username AWS --password-stdin 150151953362.
dkr.ecr.ap-northeast-2.amazonaws.com";

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/Realignist/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"

export PATH="$HOME/.poetry/bin:$PATH"
