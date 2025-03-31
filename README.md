# peter's dotfiles

## install

```bash
./install.sh
```

## mac setup

### keybindings

symlinks do not work for `DefaultKeyBinding.dict`

```bash
mkdir -p ~/Library/KeyBindings
cp Library/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/
```

### faster key repeat

```bash
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20
```

note: you need to logout and log back in after setting this.

## mono fonts

- https://github.com/zed-industries/zed-fonts/releases

## port 5000

turn off airplay receiver in `System Settings > General > AirDrop & Handoff > AirPlay Receiver`
