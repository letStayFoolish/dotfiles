#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$(uname -s)" in
  Linux)  OS_DIR="linux" ;;
  Darwin) OS_DIR="macos" ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

SRC="$REPO_DIR/$OS_DIR"
if [ ! -d "$SRC" ]; then
  echo "No config for '$OS_DIR' yet in this repo." >&2
  exit 1
fi

link() {
  local src="$1" dst="$2"
  [ -e "$src" ] || return 0
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backed up existing $dst"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -snf "$src" "$dst"
  echo "Linked $dst -> $src"
}

link "$SRC/tmux/.tmux.conf" "$HOME/.tmux.conf"
link "$SRC/nvim" "$HOME/.config/nvim"
link "$SRC/herdr/config.toml" "$HOME/.config/herdr/config.toml"
link "$SRC/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "Installed TPM. Start tmux and press prefix + I to install plugins."
fi

echo "Done."
