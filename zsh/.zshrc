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

bindkey -e
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
export EDITOR="nvim"
alias g='git'
alias vi="nvim"
alias vim="nvim"
alias ls="lsd -lFNg --group-dirs=first"
alias bat="bat --number"
alias batp="bat --paging never"
alias batpp="bat --plain --paging never"

# sensible aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/Nebuleto/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [[ -z "$ZELLIJ" ]] && [[ $TERM_PROGRAM == "ghostty" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij -l default
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

export ANDROID_HOME="/Users/Nebuleto/Library/Android/sdk"
alias cc='CLAUDE_CODE_NO_FLICKER=1 CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 CLAUDE_CONFIG_DIR=~/claude/work claude'
alias claude='CLAUDE_CODE_NO_FLICKER=1 CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 CLAUDE_CONFIG_DIR=~/claude/work claude'

. "$HOME/.grit/bin/env"

zellij_tab_name_update() {
    if [[ -n $ZELLIJ ]]; then
        local current_dir=$PWD
        if [[ $current_dir == $HOME ]]; then
            current_dir="~"
        else
            current_dir=${current_dir##*/}
        fi
        command nohup zellij action rename-pane $current_dir >/dev/null 2>&1
    fi
}

zellij_tab_name_update
chpwd_functions+=(zellij_tab_name_update)
