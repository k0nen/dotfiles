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
    brew install tmux
elif [[ "$os_name" == "Linux" ]]; then
    # Linux specific commands
    echo "Running on Linux"
    sed -i 's/robbyrussell/agnoster/' ~/.zshrc
    sudo apt-get install tmux
else
    echo "Unsupported OS"
fi

# Append custom zshrc
if ! grep -q "source $PWD/zshrc" ~/.zshrc; then
    printf "\n\nsource $PWD/zshrc\n\n" >> ~/.zshrc
fi

# Custom config files
ln -sf $DOT_DIR/gitconfig $HOME/.gitconfig
ln -sf $DOT_DIR/tmux.conf $HOME/.tmux.conf

# Python custom libraries
# Function to check if a Python package is installed
check_and_install_package() {
  package=$1
  if ! pip show $package > /dev/null 2>&1; then
    echo "$package is not installed. Installing..."
    python3 -m pip install $package
  else
    echo "$package is already installed."
  fi
}

# Example usage:
check_and_install_package "shell_gpt"
check_and_install_package "thefuck"

mkdir -p $HOME/.config/thefuck/rules
cp config/thefuck/rules/* $HOME/.config/thefuck/rules/
