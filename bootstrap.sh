#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_chezmoi() {
  if command -v chezmoi >/dev/null 2>&1; then
    return
  fi

  case "$(uname -s)" in
    Darwin)
      if ! command -v brew >/dev/null 2>&1; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi

      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi

      brew install chezmoi
      ;;
    Linux)
      mkdir -p "$HOME/.local/bin"
      sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
      export PATH="$HOME/.local/bin:$PATH"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

install_chezmoi

chezmoi --source "$DOTFILES_DIR" init
chezmoi apply

cat <<'EOF'

Bootstrap complete.

Zellij note:
  The zjstatus plugin is installed as a local wasm file, but Zellij still
  requires a one-time permission grant per machine/cache.

  On first Zellij launch, focus or click the zjstatus bar and press "y".
  If the bar is blank, run:
    zellij action focus-pane-id plugin_1
  Then press "y" to approve the plugin permissions.
EOF
