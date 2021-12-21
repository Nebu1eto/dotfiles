#!/bin/bash
[ -z "${OS}" ] && . lib/common.sh

# 우리는 리눅스(그것도 우분투)와 macOS만 지원한다.
if [ "${OS}" = "linux" ]; then
    echo 'Install Linux Dependencies.'
    
    # APT 설치
    sudo apt update
    sudo apt install -y thefuck bat build-essential python3.8 tree zsh git git-lfs htop wget postgresql mysql-client zip unzip
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

    # Bat 설치
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat

    # Exa 설치
    wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
    unzip exa-linux-x86_64-v0.10.0.zip -d exa-linux-bin
    sudo cp ./exa-linux-bin/bin/exa /usr/local/bin/
    sudo cp ./exa-linux-bin/man/exa.1 /usr/share/man/man1/
    sudo cp ./exa-linux-bin/man/exa_colors.5 /usr/share/man/man5/
    rm -rf ./exa-linux-bin
    rm -rf ./exa-linux-x86_64-v0.10.0.zip

    sudo chsh -s $(which zsh) $(whoami)
fi

if [ "${OS}" = "macos" ]; then
    echo 'Install macOS Dependencies.'
    
    # Homebrew 설치
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install exa bat python@3.8 thefuck tree thefuck zsh svn git git-lfs htop wget postgresql mariadb
    brew tap homebrew/cask-fonts
    brew install font-roboto font-roboto-mono font-fira-code
fi

# Starship 설치
FORCE=true sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# NVM / Rustup 설치
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup_init.sh
bash rustup_init.sh -y
rm -rf rustup_init.sh

rm -rf ~/.zshrc
rm -rf ~/.zplugin
rm -rf ~/.zinit
rm -rf ~/.config/starship.toml

rm -rf ~/.gitconfig
rm -rf ~/.gitignore

rm -rf ~/.vimrc
rm -rf ~/.vim 
rm -rf ~/.ideavimrc

ln -s $(pwd)/zsh/zinit ~/.zinit
ln -s $(pwd)/zsh/.zshrc ~/.zshrc
ln -s $(pwd)/zsh/starship.toml ~/.config/starship.toml

ln -s $(pwd)/vim ~/.vim
ln -s $(pwd)/vim/.vimrc ~/.vimrc
ln -s $(pwd)/vim/.ideavimrc ~/.ideavimrc

ln -s $(pwd)/git/gitignore ~/.gitignore
ln -s $(pwd)/git/gitconfig ~/.gitconfig
