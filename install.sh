#!/usr/bin/env bash

# Common packages (same name in brew and apt)
common_packages=(
  git
  ripgrep
  fzf
  bat
  eza
  jq
  fish
  neovim
  zig
)

# Detect OS
os_name=$(uname -s | tr '[:upper:]' '[:lower:]')

# Validate OS
if [ "$os_name" != "darwin" ] && [ "$os_name" != "linux" ]; then
  echo "Error: Unsupported operating system: $os_name"
  exit 1
fi

# Function to install packages using Homebrew
install_brew() {
  echo "Installing packages using Homebrew..."
  brew install "$@"
}

# Function to install packages using apt
install_apt() {
  echo "Installing packages using apt..."
  sudo apt-get update
  sudo apt-get install -y "$@"
}

# Install common packages
if [ "$os_name" = "darwin" ]; then
  install_brew "${common_packages[@]}"
elif [ "$os_name" = "linux" ]; then
  install_apt "${common_packages[@]}"
fi

# Install fd with OS-specific name
if [ "$os_name" = "darwin" ]; then
  install_brew fd
  install_brew mise
elif [ "$os_name" = "linux" ]; then
  install_apt fd-find
fi
