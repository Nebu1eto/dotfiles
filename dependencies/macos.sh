# install homebrew 
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

# install packages
brew tap paulche/sudo-touchid
brew install rustup		             \
             starship		         \
             zsh                     \
             coreutils               \
             gnupg                   \
             sudo-touchid            \
             redis                   \
             git                     \
             git-lfs                 \
             imagemagick --with-webp \
             rust                    \
             thefuck                 \
             exa                     \
             node                    \
             nvm                     \
             go                      \
             python                  \
             python3                 \
             thefuck                 \
             cmake                   \
             gradle                  \
             maven                   \
             wget                    \
             nifi                    \
             htop                    \
             cocoapods               \
             postgresql              \
             nginx                   \
             r

# install applications
brew cask install visual-studio-code            \
                    iterm2                      \
                    docker                      \
                    hyper                       \
                    rstudio                     \
                    bartender                   \
                    sketch                      \
                    parallels                   \
                    discord                     \
                    notion                      \
                    omnifocus                   \
                    tower                       \
                    paw                         \
                    dash                        \
                    pdf-expert                  \
                    microsoft-office            \
                    setapp                      \
                    xld                         \
                    appcleaner                  \
                    karabiner                   \
                    karabiner-elements          \
                    gfxcardstatus               \
                    forklift                    \
                    alfred                      \
                    google-chrome               \
                    intellij-idea               \
                    datagrip                    \
                    goland                      \
                    webstorm                    \
                    pycharm                     \
                    gitfinder
