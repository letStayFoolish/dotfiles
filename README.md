# dotfiles

Personal tmux and nvim configuration, kept in sync across machines.

```
linux/
├── tmux/.tmux.conf
└── nvim/           # full ~/.config/nvim
macos/               # added from the Mac
install.sh
```

## Setup on a new machine

```
git clone git@github.com:letStayFoolish/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` detects the OS (`linux` or `macos`), symlinks `.tmux.conf` and
`nvim/` into place (backing up anything already there), and clones
[tpm](https://github.com/tmux-plugins/tpm) if missing. After that, start
tmux and press `prefix + I` to install the tmux plugins.
