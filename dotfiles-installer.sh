#! /bin/bash
ln -sf ~/dotfiles/.vim/ ~/.vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/.zsh/ ~/.zsh
ln -sf ~/dotfiles/.zshrc ~/.zshrc

chmod +x dotfiles-installer.sh
bash ./dotfiles-installer.sh
