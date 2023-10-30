#!/usr/bin/env fish

rm -f ~/.gitignore
ln -s ~/src/sys-config/gitignore ~/.gitignore
git config --global core.excludesfile ~/.gitignore

rm -rf ~/.config
ln -fs ~/src/sys-config/config/  ~/.config
