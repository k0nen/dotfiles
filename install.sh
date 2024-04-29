#! /bin/bash
# Use this script for brand-new systems

DOT_DIR=$PWD
ZSH=$HOME/.oh-my-zsh

# Check default shell
default_shell=$SHELL
if [[ "default_shell" == "/bin/bash" ]]; then
    # Set zsh to default
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s /bin/zsh
fi

# Change zsh theme
os_name="$(uname -s)"  # Get the OS name
if [[ "$os_name" == "Darwin" ]]; then
    # macOS specific commands
    echo "Running on macOS"
    sed -i '' 's/robbyrussell/agnoster/' ~/.zshrc
elif [[ "$os_name" == "Linux" ]]; then
    # Linux specific commands
    echo "Running on Linux"
    sed -i 's/robbyrussell/agnoster/' ~/.zshrc
else
    echo "Unsupported OS"
fi

# Append custom zshrc
if ! grep -q "source $PWD/zshrc" ~/.zshrc; then
    printf "\n\nsource $PWD/zshrc\n\n" >> ~/.zshrc
fi

# Custom config files
ln -sf $DOT_DIR/gitconfig $HOME/.gitconfig

