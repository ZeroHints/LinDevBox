# Stage 1: Build Binaries
FROM ubuntu:22.04 as builder

WORKDIR /tmp
RUN apt update && \
apt install -y ninja-build gettext cmake unzip curl git file&& \
# Building neovim package from source: https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
# /tmp/neovim
git clone https://github.com/neovim/neovim && \
cd neovim && \
git checkout tags/v0.9.1 && \
make && \
cd build && \
cpack -G DEB

# Stage 2: Final Image
FROM ubuntu:22.04

LABEL maintainer="AgentZero"

SHELL ["/bin/bash", "-c"]

WORKDIR /tmp

COPY --from=builder /tmp/neovim/build/nvim-linux64.deb nvim-linux64.deb

RUN apt update && \
# General tools
apt install -y git sudo curl passwd xclip && \
# Install nvim
dpkg -i nvim-linux64.deb && \
rm nvim-linux64.deb && \
# NodeJs
apt install -y nodejs npm && \
# Python
apt install -y python3 python3-pip && \
update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
update-alternatives --install /usr/bin/py py /usr/bin/python3 1 && \
# Astro nvim requirements
apt install -y ripgrep && \
# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y && \
source "$HOME/.cargo/env" && \
# Rust tools
cargo +stable install bottom  && \
cargo +stable install tree-sitter-cli && \
# Go
curl -O https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz && \
rm -rf /usr/local/go && \
tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && \
rm go1.21.0.linux-amd64.tar.gz && \
export PATH=$PATH:/usr/local/go/bin && \
export GOPATH=$HOME/go && \
export PATH=$PATH:$GOPATH/bin && \
# Go tools
go install github.com/jesseduffield/lazygit@latest && \
go install github.com/dundee/gdu/v5/cmd/gdu@latest && \
# Clean apt
apt clean && \
# Create user and make it admin
groupadd -g 1000 dev && \
useradd -m -u 1000 -g dev -s /bin/bash dev && \
echo "dev:1234" | chpasswd && \
usermod -aG sudo dev

# Set Go environment variables
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin

USER dev

WORKDIR /home/dev

CMD ["bash"]