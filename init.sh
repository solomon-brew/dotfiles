#!/bin/bash

# Otimizações para DNF mais rápido
echo -e "\n# Otimizações para DNF mais rápido\nmax_parallel_downloads=10\nfastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf

# Atualização e instalação de pacotes necessários
sudo dnf copr enable dejan/lazygit -y
sudo dnf group install c-development -y
sudo dnf up -y

sudo dnf install zsh git bat xclip tmux direnv zoxide httpie lazygit keychain neovim fastfetch gh fzf ripgrep fd tldr stow docker-cli docker-compose docker-distribution cargo python-devel pipx -y

# Adiciona o usuário ao grupo docker
sudo usermod -aG docker $USER

# Clona e instala o eza
mkdir -p ~/downloads
cd ~/downloads
git clone https://github.com/eza-community/eza.git
cd eza
cargo install --path .
cd ~

# Define o shell padrão como zsh
chsh -s /usr/bin/zsh

# Configurações globais do git
git config --global init.defaultBranch main
git config --global user.email "ravicorreia@icloud.com"
git config --global user.name "Ravi Correia"

# Clona o repositório de dotfiles e aplica as configurações
git clone git@github.com:solomon-brew/dotfiles
cd dotfiles
stow .
cd ~