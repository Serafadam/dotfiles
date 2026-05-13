#!/usr/bin/env bash
apt-get update \
   && apt-get -y install --no-install-recommends software-properties-common \
   ssh \
   bat \
   stow \
   git \
   ripgrep \
   fd-find \
   golang \
   clang-format \
   clangd \
   clang-tidy \
   libusb-1.0-0-dev \
   wget \
   zsh \
   gdb \
   python3-venv \
   ninja-build \
   gettext \
   cmake \
   unzip \
   curl \
   build-essential \
   tmux \
   htop \
   iputils-ping\
   lsd \
   python3-pip

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -LsSf https://astral.sh/uv/install.sh | sh
cd  /usr/local/bin/ && \
wget https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-linux-x86_64.tar.gz && \
tar zxfv nvim-linux-x86_64.tar.gz && \
rm -rf nvim-linux-x86_64.tar.gz && \
ln -sf /usr/local/bin/nvim-linux-x86_64/bin/nvim /usr/local/bin/

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


add-apt-repository ppa:zhangsongcui3371/fastfetch
apt update && apt install fastfetch
# regular install won't work in this environment for some reason
git clone https://github.com/junegunn/fzf.git /tmp/.fzf
cd /tmp/.fzf && make install && ./install --all
rm -rf /tmp/.fzf
export DEBIAN_FRONTEND=dialog && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
cd /tmp && git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
cd pokemon-colorscripts && sudo ./install.sh
