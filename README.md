# dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Install

```sh
git clone https://github.com/Hazealign/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## Apply

```sh
chezmoi apply
```

## Packages

macOS packages are managed with `Brewfile` and installed by chezmoi during
`chezmoi apply`. Linux packages are installed from the distro package manager
when `apt`, `dnf`, or `pacman` is available.

## Screenshot

Based on Nord Colorscheme.

### Shell

![](https://raw.githubusercontent.com/Hazealign/dotfiles/master/images/shell_screen.png)

### Vim

![](https://raw.githubusercontent.com/Hazealign/dotfiles/master/images/vim_screen.png)
