#! /bin/bash
ln -s ~/dotfiles/.vim/ ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.zsh/ ~/.zsh
ln -s ~/dotfiles/.zshrc ~/.zshr

chmod +x dotfiles-installer.sh
bash ./dotfiles-installer.sh
