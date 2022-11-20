#!/bin/bash
[ -z "${OS}" ] && . lib/common.sh

# 우리는 리눅스(그것도 우분투 22.04)와 macOS만 지원한다.
if [ "${CODESPACE_NAME}" != "" ]; then
    echo "Codespaces Dependencies (Debian Bullseye)."

    git submodule update --init --recursive

    curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo python3.9 get-pip.py
    sudo python3.10 get-pip.py
    rm -rf get-pip.py

    sudo apt update

    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
    sudo dpkg -i nvim-linux64.deb
    rm -rf nvim-linux64.deb

    wget https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb
    sudo dpkg -i bat_0.22.1_amd64.deb
    rm -rf bat_0.22.1_amd64.deb

    sudo pip install thefuck

    wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
    sudo dpkg -i lsd_0.23.1_amd64.deb
    rm -rf lsd_0.23.1_amd64.deb

    sudo chsh -s $(which zsh) $(whoami)
fi;


if [ "${OS}" = "linux" ] && [ "${CODESPACE_NAME}" = "" ]; then
    echo 'Install Linux Dependencies.'

    # APT 설치
    sudo apt update
    sudo apt install -y bat build-essential tree zsh git git-lfs htop wget postgresql-client mysql-client zip unzip 

    # python 설치
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update 
    sudo apt install python3.9-full python3.10-full -y
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.9 2
    sudo update-alternatives --install /usr/bin/python3 python /usr/bin/python3.10 1
    sudo update-alternatives --install /usr/bin/python3 python /usr/bin/python3.9 2

    curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo python3.9 get-pip.py
    sudo python3.10 get-pip.py
    rm -rf get-pip.py

    # thefuck 설치
    sudo pip install thefuck

    # Bat 설치
    mkdir -p ~/.local/bin
    ln -s /usr/bin/bat ~/.local/bin/bat

    # LSDeluxe 설치
    arch=$(uname -i)
    if [[ $arch == x86_64* ]]; then
        wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
        sudo dpkg -i lsd_0.23.1_amd64.deb
        rm -rf lsd_0.23.1_amd64.deb
    elif [[ $arch == arm* ]] || [[ $arch = aarch64 ]]; then
        wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_arm64.deb
        sudo dpkg -i lsd_0.23.1_arm64.deb
        rm -rf lsd_0.23.1_arm64.deb
    fi;

    sudo chsh -s $(which zsh) $(whoami)
fi;

if [ "${OS}" = "macos" ]; then
    echo 'Install macOS Dependencies.'
    
    # Homebrew 설치
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install lsd bat python@3.9 python@3.10 python@3.11 thefuck tree thefuck zsh svn git git-lfs htop wget postgresql mariadb
    brew tap homebrew/cask-fonts
    brew install font-roboto font-roboto-mono font-fira-code
fi;

# Starship 설치
FORCE=true sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# NVM / Rustup / Poetry 설치
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup_init.sh
bash rustup_init.sh -y
rm -rf rustup_init.sh
curl -sSL https://install.python-poetry.org | python3 -

rm -rf ~/.zshrc
rm -rf ~/.zplugin
rm -rf ~/.zinit
rm -rf ~/.config/starship.toml

rm -rf ~/.gitconfig
rm -rf ~/.gitignore

rm -rf ~/.vimrc
rm -rf ~/.vimrc.local 
rm -rf ~/.vim
rm -rf ~/.ideavimrc
rm -rf ~/.config/nvim

rm -rf ~/.ssh

ln -s $(pwd)/zsh/zinit ~/.zinit
ln -s $(pwd)/zsh/.zshrc ~/.zshrc
ln -s $(pwd)/zsh/starship.toml ~/.config/starship.toml

mkdir -p ~/.vim/plugged 
mkdir -p ~/.ssh
mkdir -p ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s $(pwd)/vim/vimrc ~/.vimrc
ln -s $(pwd)/vim/vimrc.local ~/.vimrc.local
ln -s $(pwd)/vim/vimrc ~/.config/nvim/init.vim
ln -s $(pwd)/vim/coc-settings.json ~/.config/nvim/coc-settings.json

ln -s $(pwd)/git/gitignore ~/.gitignore
ln -s $(pwd)/git/gitconfig ~/.gitconfig

ln -s $(pwd)/ssh/config ~/.ssh/config
ln -s $(pwd)/ssh/allowed_signers ~/.ssh/allowed_signers

if [ "${CODESPACE_NAME}" != "" ]; then
    git config --global commit.gpgsign false
fi;
