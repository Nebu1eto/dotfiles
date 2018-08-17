# update mirror 
# only suggest for korean users.
# --------------------------------
# sudo cp /etc/apt/sources.list ~/sources.list.old
# sudo sed -i 's/us.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# sudo sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

# install base package
sudo apt update
sudo apt install curl               \ 
                 wget               \
                 vim                \
                 git-core           \
                 git-lfs            \
                 build-essential    \
                 cmake              \
                 rustc              \
                 golang-go          \
                 postgresql         \
                 postgresql-contrib \
                 mongodb            \
                 redis              \
                 nodejs             \
                 npm                \
                 gradle             \
                 maven              \
                 htop               \
                 sysstat            \
                 python3            \
                 python2.7          \
                 nginx              \
                 gnupg              \
                 zsh                \
                 r-base             \
                 thefuck            \
                 libgit2

# install nvm, change shell
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
chsh -s `which zsh`

# build exa
curdir=$(pwd)
sudo mkdir -p /tmp/work
sudo chmod -R 777 /tmp/work
cd /tmp/work
git clone https://github.com/ogham/exa.git; cd exa;
cargo build --release; cd $curdir;
sudo rm -rf /tmp/work

# install bat
cargo install bat;
