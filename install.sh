#! /bin/bash

DOT_DIR=$PWD
ZSH=$HOME/.oh-my-zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh

ln -sf $DOT_DIR/tmux.conf $HOME/.tmux.conf
ln -sf $DOT_DIR/zshrc $HOME/.zshrc

pip3 install thefuck --user

cp jupyter/shortcuts.jupyterlab-setting ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-setting

