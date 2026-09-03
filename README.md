# dotfiles

Personal tmux, nvim, herdr and Alacritty configuration, kept in sync across machines.

```
linux/
├── tmux/.tmux.conf
├── nvim/                 # full ~/.config/nvim
├── herdr/config.toml
├── alacritty/alacritty.toml
└── gnome-terminal/apply.sh   # dconf, not a plain file (see below)
macos/                     # added from the Mac
install.sh
```

Font everywhere (tmux, nvim, herdr's own UI, Alacritty, GNOME Terminal) is
**JetBrainsMono Nerd Font Mono** — the fixed-width Nerd Font variant, needed
so icons/glyphs don't break terminal alignment.

## Setup on a new machine

```
git clone git@github.com:letStayFoolish/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh`:
1. Installs `tmux` and `herdr` if missing (`apt`/`brew` for tmux, `brew` or
   the official `herdr.dev/install.sh` for herdr).
2. Symlinks each config file into place (backing up anything already there),
   and clones [tpm](https://github.com/tmux-plugins/tpm) if missing.
3. On Linux, if GNOME Terminal is the desktop's terminal, applies the same
   font + Catppuccin Mocha palette to its default profile.

Any config folder missing for the current OS is skipped, so `macos/` can lag
behind `linux/`. After first install, start tmux and press `prefix + I` to
install the tmux plugins.

## What `install.sh` can't cover

tmux, nvim, herdr and Alacritty all read plain config files, so symlinking
them is enough. Some things aren't config files though — they live in a
settings database the OS owns — so they need a one-time manual step (or a
platform-specific script, like `linux/gnome-terminal/apply.sh` above) instead
of a symlink:

- **Linux / GNOME Terminal** — handled automatically by `install.sh`
  (`linux/gnome-terminal/apply.sh`), since its settings live in `dconf`, not
  a file. Re-run that script by hand if you ever create a new profile.
- **Linux / another terminal app** (Konsole, etc.) — set font to
  `JetBrainsMono Nerd Font Mono` and, ideally, import a Catppuccin Mocha
  theme by hand; not scripted here.
- **macOS / Terminal.app or iTerm2** — same idea, not yet scripted (no Mac to
  test against). When the `macos/` folder is added: install the font, set it
  as the profile font, and import a Catppuccin Mocha color scheme
  ([catppuccin/iterm](https://github.com/catppuccin/iterm) has ready-made
  `.itermcolors` files). Alacritty on macOS needs no extra step beyond
  installing Alacritty itself — `macos/alacritty/alacritty.toml` covers it
  the same way as on Linux.

None of this affects tmux's own status bar/colors (`tmux.conf` +
`catppuccin/tmux`) or nvim's colorscheme — those apply regardless of which
terminal app is hosting them, as long as the terminal supports true color.
