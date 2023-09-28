# ================== Stage 1: Build Binaries ==================
FROM ubuntu:22.04 as builder

RUN apt update && \
apt install -y ninja-build gettext cmake unzip curl git file && \
apt clean

WORKDIR /tmp

# Building neovim package from source: https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
# Output: /tmp/neovim/build/nvim-linux64.deb
RUN git clone https://github.com/neovim/neovim && \
cd neovim && \
git checkout tags/v0.9.1 && \
make && \
cd build && \
cpack -G DEB

# ================== Stage 2: Final Image ==================
FROM ubuntu:22.04

LABEL maintainer="AgentZero"

SHELL ["/bin/bash", "-c"]

# Install binaries
WORKDIR /tmp
COPY --from=builder /tmp/neovim/build/nvim-linux64.deb nvim-linux64.deb

# Setup essential packages
RUN apt update && \
apt install -y git sudo curl xclip ripgrep unzip wget tar gzip nodejs npm python3 python3-pip python3-venv zsh && \
apt clean && \
# Python
update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
update-alternatives --install /usr/bin/py py /usr/bin/python3 1 && \
# Nvim
dpkg -i nvim-linux64.deb && \
rm nvim-linux64.deb && \
# Go
curl -s -O https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz && \
rm -rf /usr/local/go && \
tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && \
rm go1.21.0.linux-amd64.tar.gz

# Create user and make it admin
RUN groupadd -g 1000 dev && \
useradd -m -u 1000 -g dev -s /bin/zsh dev && \
echo "dev:1234" | chpasswd && \
usermod -aG sudo dev

USER dev
WORKDIR /home/dev

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=$HOME/dev/go
ENV PATH=$PATH:$GOPATH/bin

RUN \
# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y && \
source ~/.cargo/env && \
# Rust tools
cargo +stable install bottom  && \
cargo +stable install tree-sitter-cli && \
cargo +stable install lsd && \
# Go
export PATH=$PATH:/usr/local/go/bin && \
export GOPATH=$HOME/go && \
export PATH=$PATH:$GOPATH/bin && \
# Go tools
go install github.com/jesseduffield/lazygit@latest && \
go install github.com/dundee/gdu/v5/cmd/gdu@latest

COPY assets/.config/nvim .config/nvim
COPY entrypoint.sh entrypoint.sh

USER root
RUN \
chmod 777 -R .config/nvim && \
chmod +x entrypoint.sh

USER dev 
RUN \
nvim --headless -c "Lazy! sync" -c "qa"

SHELL ["/bin/zsh", "-c"]

# Setup zsh theme and plugins: https://ohmyz.sh/#install
RUN \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
source .zshrc && \
mkdir -p "$ZSH_CUSTOM/themes" && \
mkdir -p "$ZSH_CUSTOM/plugins" && \
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k && \
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

COPY assets/.p10k.zsh .p10k.zsh
COPY assets/.zshrc .zshrc
COPY assets/.env_vars.sh .env_vars.sh

ARG CACHEBUST=1

ENTRYPOINT ["/home/dev/entrypoint.sh"]