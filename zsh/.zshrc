# initialize zplug
source ~/.zplug/init.zsh

# Prompt command which is used to set the prompt, includes some extra useful
# functionality such as showing the last exit code
__set_prompt() {
    local EXIT="$?"
    # Capture last command exit flag first

    # Clear out prompt
    PS1=""

    # If the last command didn't exit 0, display the exit code
    [ "$EXIT" -ne "0" ] && PS1+="$EXIT "

    # identify debian chroot, if one exists
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
      PS1+="${debian_chroot:+($(cat /etc/debian_chroot))}"
    fi

    # Render the appropriate format depending on whether we are in a git repo
    PS1+="$(glit "$PS1_FMT" -e "$PS1_ELSE_FMT")"
}

# define environmental variables
export PATH=$PATH:/usr/local/bin:~/.cargo/bin:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go
export PS1_FMT="\<#m;*(\b)#m(\B(#~('..')))\(#g(\+)#r(\-))>\[#g;*(\M\A\R\D)#r;*(\m\a\u\d)]\{#m;*;_(\h('@'))}':'#y;*('\w')'\n\$ '"
export PS1_ELSE_FMT="#g(#*('\u')'@\h')':'#b;*('\w')'\$ '"
export PROMPT_COMMAND=__set_prompt
export NVM_DIR=~/.nvm
export PURE_PROMPT_SYMBOL="λ"

# define modules
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:'pure.zsh', from:github, as:theme
zplug 'timothyrowan/betterbrew-zsh-plugin', from:github, use:'betterbrew.plugin.zsh'
zplug 'djui/alias-tips'
zplug 'zdharma/fast-syntax-highlighting'
zplug 'zdharma/history-search-multi-word'
zplug 'zsh-users/zsh-autosuggestions', use:'zsh-autosuggestions.plugin.zsh'
zplug 'lukechilds/zsh-better-npm-completion', defer:2
zplug 'b4b4r07/zplug-doctor', lazy:yes
zplug 'b4b4r07/zplug-cd', lazy:yes
zplug 'b4b4r07/zplug-rm', lazy:yes

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
    echo
fi

zplug load

# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

# define some aliases.
alias g='git'
alias vi="vim"
alias ls="exa --long -aRT -L=1 --git -h"
alias cat="bat"
alias hist="history | tail -n"

# initialize the f**k
eval $(thefuck --alias)
