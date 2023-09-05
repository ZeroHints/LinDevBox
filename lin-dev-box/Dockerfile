# ================== Stage 1: Build Binaries ==================
FROM ubuntu:22.04 as builder

RUN apt update && \
apt install -y ninja-build gettext cmake unzip curl git file && \
apt clean

WORKDIR /tmp

# Building neovim package from source: https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
# /tmp/neovim
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

# Set non-interactive environment
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
COPY --from=builder /tmp/neovim/build/nvim-linux64.deb nvim-linux64.deb

# Setup essential packages
RUN apt update && \
apt install -y git sudo curl xclip ripgrep nodejs npm python3 python3-pip && \
apt clean && \
# Python
update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
update-alternatives --install /usr/bin/py py /usr/bin/python3 1 && \
# Nvim
dpkg -i nvim-linux64.deb && \
rm nvim-linux64.deb && \
# Go
curl -O https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz && \
rm -rf /usr/local/go && \
tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && \
rm go1.21.0.linux-amd64.tar.gz

# Create user and make it admin
RUN groupadd -g 1000 dev && \
useradd -m -u 1000 -g dev -s /bin/bash dev && \
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
source "$HOME/.cargo/env" && \
# Rust tools
cargo +stable install bottom  && \
cargo +stable install tree-sitter-cli && \
# Go
export PATH=$PATH:/usr/local/go/bin && \
export GOPATH=$HOME/go && \
export PATH=$PATH:$GOPATH/bin && \
# Go tools
go install github.com/jesseduffield/lazygit@latest && \
go install github.com/dundee/gdu/v5/cmd/gdu@latest

RUN \
# AstroNvim base config
git clone --depth 1 https://github.com/AstroNvim/AstroNvim "$HOME/.config/nvim" && \
nvim +PlugInstall +qall && \
nvim +MasonUpdate +qall

CMD ["bash"]