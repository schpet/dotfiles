# peter's dotfiles

## install

```bash
./install.sh
```

## mac setup

### keybindings

symlinks do not work for `DefaultKeyBinding.dict`

```bash
# copy over keybindings (symlinks do not work)
mkdir -p ~/Library/KeyBindings
cp Library/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/

# or do this with diffwrite
diffwrite ~/Library/KeyBindings/DefaultKeyBinding.dict < Library/KeyBindings/DefaultKeyBinding.dict

# setup the kill ring
defaults write -g NSTextKillRingSize -int 6
```



### faster key repeat

```bash
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20
```

note: you need to logout and log back in after setting this.

### keyboard

System settings Keyboard Keyboard shortcuts... Input sources > uncheck them if they are checked

## mono fonts

- https://github.com/zed-industries/zed-fonts/releases

## port 5000

turn off airplay receiver in `System Settings > General > AirDrop & Handoff > AirPlay Receiver`
