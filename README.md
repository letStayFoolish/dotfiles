# dotfiles

Personal tmux, nvim, herdr and Alacritty configuration, kept in sync across machines.

```
linux/
├── tmux/.tmux.conf
├── nvim/                 # full ~/.config/nvim
├── herdr/config.toml
├── alacritty/alacritty.toml
└── gnome-terminal/apply.sh   # dconf, not a plain file (see below)
macos/
├── tmux/.tmux.conf
├── herdr/config.toml
└── iterm2/
    ├── typecraft.json    # iTerm2 Dynamic Profile (font + colors)
    └── apply.sh           # installs the fonts, sets it as default profile
install.sh
```

Font on Linux (tmux, nvim, herdr's own UI, Alacritty, GNOME Terminal) is
**JetBrainsMono Nerd Font Mono** — the fixed-width Nerd Font variant, needed
so icons/glyphs don't break terminal alignment. tmux/herdr on macOS use the
same tools but keep their **own Catppuccin Mocha theme**, deliberately kept
different from Linux's — see "Per-OS differences" below. iTerm2 on macOS uses
**MesloLGL Nerd Font Mono** instead, again a deliberate choice for that
machine, not an oversight.

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
   font + Catppuccin Mocha palette to its default profile. On macOS, installs
   the MesloLGL/Cascadia Nerd Fonts and sets the `typecraft.json` profile as
   iTerm2's default (`macos/iterm2/apply.sh`).

Any config folder missing for the current OS is skipped — `macos/` doesn't
have `nvim/` or `alacritty/` yet, only `tmux/`, `herdr/` and `iterm2/`. After
first install, start tmux and press `prefix + I` to install the tmux plugins.

## Per-OS differences

`macos/tmux/.tmux.conf` and `macos/herdr/config.toml` are **not** copies of
the Linux ones — they intentionally keep a different Catppuccin theme/feel
that was tuned on the Mac, plus a few independent settings (e.g. herdr's
toast delivery, `agent_panel_sort`). Non-theme behavior (like panes opening
in the current pane's directory) is kept in sync between the two where it
makes sense. When changing either file, decide deliberately whether the
change belongs on one OS or both, rather than assuming they should match.

## What `install.sh` can't cover

tmux and herdr read plain config files, so symlinking them is enough.
iTerm2's *profile* (font + colors) is also a plain file — a Dynamic Profile
JSON (`macos/iterm2/typecraft.json`), symlinked into
`~/Library/Application Support/iTerm2/DynamicProfiles/` like everything else.
What can't be symlinked is *which* profile is the default and whether the
fonts it references are installed — those live in iTerm2's plist and in
`/Library/Fonts`, not in a config file, so `macos/iterm2/apply.sh` handles
them (installs the fonts via `brew`, sets `Default Bookmark Guid`). Re-run it
by hand after editing the profile's Guid or picking a new default.

- **Linux / GNOME Terminal** — handled automatically by `install.sh`
  (`linux/gnome-terminal/apply.sh`), since its settings live in `dconf`, not
  a file. Re-run that script by hand if you ever create a new profile.
- **Linux / another terminal app** (Konsole, etc.) — set font to
  `JetBrainsMono Nerd Font Mono` and, ideally, import a Catppuccin Mocha
  theme by hand; not scripted here.
- **macOS / Terminal.app** — not covered; iTerm2 is the terminal in use here.

None of this affects tmux's own status bar/colors (`tmux.conf` +
`catppuccin/tmux`) or nvim's colorscheme — those apply regardless of which
terminal app is hosting them, as long as the terminal supports true color.
