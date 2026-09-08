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

ensure_tmux() {
  command -v tmux >/dev/null 2>&1 && return 0
  echo "Installing tmux..."
  if [ "$OS_DIR" = "linux" ] && command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y tmux
  elif command -v brew >/dev/null 2>&1; then
    brew install tmux
  else
    echo "No supported package manager found for tmux; install it manually." >&2
    return 1
  fi
}

ensure_herdr() {
  command -v herdr >/dev/null 2>&1 && return 0
  echo "Installing herdr..."
  if command -v brew >/dev/null 2>&1; then
    brew install herdr
  else
    curl -fsSL https://herdr.dev/install.sh | sh
  fi
}

ensure_tmux
ensure_herdr

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
link "$SRC/iterm2/typecraft.json" "$HOME/Library/Application Support/iTerm2/DynamicProfiles/typecraft.json"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "Installed TPM. Start tmux and press prefix + I to install plugins."
fi

if [ "$OS_DIR" = "linux" ] && command -v gsettings >/dev/null 2>&1 && [ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]; then
  "$REPO_DIR/linux/gnome-terminal/apply.sh" || echo "Skipped GNOME Terminal styling (not the active desktop terminal)."
fi

if [ "$OS_DIR" = "macos" ]; then
  "$REPO_DIR/macos/iterm2/apply.sh" || echo "Skipped iTerm2 setup."
fi

echo "Done."
