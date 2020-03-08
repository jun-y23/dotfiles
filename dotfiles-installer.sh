#! /bin/bash
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.vim/ ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.zsh/ ~/.zsh
ln -s ~/dotfiles/.zshrc ~/.zshr

chmod +x dotfiles-installer.sh
./dotfiles-installer.sh
