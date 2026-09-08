#!/usr/bin/env bash
# iTerm2 keeps its settings in a plist, not a plain config file. The profile
# itself (font + Catppuccin Mocha colors) is a Dynamic Profile JSON that gets
# symlinked like everything else in this repo (see install.sh); this script
# only installs the fonts it references and makes it the default profile.
set -euo pipefail

command -v defaults >/dev/null 2>&1 || exit 0
[ -d "/Applications/iTerm.app" ] || exit 0

if command -v brew >/dev/null 2>&1; then
  brew install --cask font-meslo-lg-nerd-font font-cascadia-code-nf 2>/dev/null || true
fi

GUID="00e90099-4367-49b9-9cf3-a0eb4e100044"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" "$GUID"

echo "Set iTerm2 default profile to Typecraft (Catppuccin Mocha). Restart iTerm2 to pick it up."
