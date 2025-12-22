# dotfiles

My dotfiles and environment configurations.

A clean and simple dotfiles, optimized to wsl.

echo -e "\n# Otimizações para DNF mais rápido\nmax_parallel_downloads=10\nfastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf

sudo dnf up -y
sudo dnf copr enable atim/lazygit -y
sudo dnf group install c-development -y

sudo dnf install zsh git bat xclip tmux direnv zoxide httpie lazygit neovim fastfetch gh fzf ripgrep fd tldr stow docker-cli docker-compose docker-distribution cargo python-devel pipx -y

sudo usermod -aG docker $USER

mkdir -p ~/downloads
cd ~/downloads
git clone https://github.com/eza-community/eza.git
cd eza
cargo install --path .
cd ~

chsh -s /usr/bin/zsh
git config --global init.defaultBranch main
git config --global user.email "ravic@ciandt.com"
git config --global user.name "Ravi Correia"
git config --global core.sshCommand "/mnt/c/Windows/System32/OpenSSH/ssh.exe"
git clone git@github.com:ravicorreia/dotfiles
cd dotfiles
stow .
cd ~
