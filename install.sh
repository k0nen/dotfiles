#! /bin/bash
# Use this script for brand-new systems

DOT_DIR=$PWD
ZSH=$HOME/.oh-my-zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh

printf "\n\nsource $PWD/zshrc\n\n" > ~/.zshrc

