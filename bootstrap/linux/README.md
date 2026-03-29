# Linux Bootstrap

This folder contains manual bootstrap notes for setting up a new Linux machine. These files are tracked in the dotfiles repo, but they are not managed into `$HOME` by chezmoi and they are not run automatically by `chezmoi apply`.

Use this when you want a safe, explicit first-run setup step for a new machine.

## Ubuntu base packages

Install the base packages with:

```bash
sudo apt install -y \
  git \
  vim \
  gimp \
  gnome-tweaks \
  qbittorrent \
  ffmpeg \
  htop \
  tree \
  ncdu \
  build-essential \
  curl \
  ca-certificates \
  xz-utils \
  ripgrep \
  fd-find \
  jq \
  tmux \
  unzip \
  xclip
```

## Miniconda

Install Miniconda using Anaconda's official Linux installer guide:

- Overview: https://www.anaconda.com/docs/getting-started/miniconda/install/overview
- Linux installer: https://www.anaconda.com/docs/getting-started/miniconda/install/linux-install

Minimal Linux x86 flow:

```bash
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ~/Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda list
```

On this setup, the Conda shell hook should live in the managed `chezmoi` Bash config rather than relying on `conda init` rewriting `.bashrc`.

## nvm

Install `nvm` from the official `nvm-sh/nvm` project if needed:

- https://github.com/nvm-sh/nvm

## Rust

Some tools in this setup, such as `shpool`, are installed with Cargo and need a Rust toolchain first.

Install Rust using the official `rustup` installer:

- https://rustup.rs/

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

## shpool

Install `shpool` after Rust is available:

- https://github.com/shell-pool/shpool

```bash
cargo install shpool
mkdir -p ~/.config/systemd/user
curl -fsSL https://raw.githubusercontent.com/shell-pool/shpool/latest/systemd/shpool.service -o ~/.config/systemd/user/shpool.service
curl -fsSL https://raw.githubusercontent.com/shell-pool/shpool/latest/systemd/shpool.socket -o ~/.config/systemd/user/shpool.socket
systemctl --user daemon-reload
systemctl --user enable --now shpool.socket
```

On this setup, the managed dotfiles should own the final `shpool` systemd units and Bash integration after bootstrap.
