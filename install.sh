#! /bin/bash

DOT_DIR=$PWD
ZSH=$HOME/.oh-my-zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh

ln -sf $DOT_DIR/tmux.conf $HOME/.tmux.conf
ln -sf $DOT_DIR/zshrc $HOME/.zshrc
ln -sf $DOT_DIR/gitconfig $HOME/.gitconfig

pip3 install thefuck --user

