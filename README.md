# dotfiles

Personal tmux, nvim, herdr and Alacritty configuration, kept in sync across machines.

```
linux/
├── tmux/.tmux.conf
├── nvim/                 # full ~/.config/nvim
├── herdr/config.toml
└── alacritty/alacritty.toml
macos/                     # added from the Mac
install.sh
```

## Setup on a new machine

```
git clone git@github.com:letStayFoolish/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` detects the OS (`linux` or `macos`), symlinks each config file
into place (backing up anything already there), and clones
[tpm](https://github.com/tmux-plugins/tpm) if missing. After that, start
tmux and press `prefix + I` to install the tmux plugins. Any config folder
missing for the current OS is skipped, so `macos/` can lag behind `linux/`.
