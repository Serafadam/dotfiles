apt-get update \
   && apt-get -y install --no-install-recommends software-properties-common \
   ssh \
   bat \
   stow \
   git \
   ripgrep \
   fd-find \
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
   python3-pip

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

pip3 install cppcheck

git clone --branch release-0.10 https://github.com/neovim/neovim.git && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install 18 && nvm use 18

export DEBIAN_FRONTEND=dialog && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
