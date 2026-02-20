#!/bin/bash

# Optimizations for faster DNF
echo -e "\n# Otimizações para DNF mais rápido\nmax_parallel_downloads=10\nfastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf

# Update the system and install necessary packages
sudo dnf copr enable dejan/lazygit -y
sudo dnf group install c-development -y
sudo dnf up -y

sudo dnf install zsh git bat xclip tmux direnv zoxide httpie lazygit keychain neovim fastfetch gh fzf ripgrep fd tldr stow docker-cli docker-compose docker-distribution cargo python-devel pipx -y

# Adds the user to the docker group
# This allows the user to run docker commands without sudo, which is more convenient and secure.
sudo usermod -aG docker $USER

# Creates basics directories
mkdir -p ~/repositories
mkdir -p ~/bin
mkdir -p ~/downloads  
mkdir -p ~/.ssh
mkdir -p ~/.config

# Clones the eza repository from GitHub, installs it using cargo, and then returns to the home directory.
cd ~/downloads
git clone https://github.com/eza-community/eza.git
cd eza
cargo install --path .
cd ~

# Set the default shell to zsh, which is a more powerful and customizable shell than bash. This allows the user to take advantage of the features and plugins available for zsh.
chsh -s /usr/bin/zsh

# Global git configurations
git config --global init.defaultBranch main
git config --global user.email "ravicorreia@icloud.com"
git config --global user.name "Ravi Correia"

# Create an SSH key pair for GitHub authentication.
ssh-keygen -t ed25519 -f ~/.ssh/id_github -C "ravicorreia@icloud.com" -N ""
eval $(keychain --quiet --eval id_github)
bat --color=always ~/.ssh/id_github.pub | xclip -sel clip

# Wait for the user to add the SSH key to their GitHub account before proceeding. This is necessary because the next step involves cloning a private repository, which requires authentication with the SSH key.
read -p "A chave SSH pública foi copiada para a área de transferência. Por favor, adicione-a à sua conta do GitHub e pressione Enter para continuar..."

# Clones the dotfiles repository from GitHub, uses stow to apply the configurations.
git clone git@github.com:solomon-brew/dotfiles
cd dotfiles
stow .
cd ~