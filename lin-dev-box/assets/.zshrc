export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom" # Would you like to use another custom folder than $ZSH/custom?

export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/dev/go"

export TERM="xterm-256color"
export LS_COLORS="ow=01;36;40"
export EDITOR='nvim'
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8 # You may need to manually set your language environment
# export ARCHFLAGS="-arch x86_64" # Compilation flags


export PATH=$GOPATH/bin:/usr/local/bin:/usr/local/go/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k" # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
DISABLE_LS_COLORS="true" # Disable ls colors
# CASE_SENSITIVE="true" # Case-sensitive completion.
# HYPHEN_INSENSITIVE="true" # Case-sensitive completion must be off. _ and - will be interchangeable.
# DISABLE_MAGIC_FUNCTIONS="true" # Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_AUTO_TITLE="true" # Uncomment the following line to disable auto-setting terminal title.
# ENABLE_CORRECTION="true" # Uncomment the following line to enable command auto-correction.

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or set a custom format using the strftime function format specifications, see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# eval "$(ssh-agent -s)"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

# Set personal aliases, overriding those provided by oh-my-zsh libs. For a full list of active aliases, run `alias`.
alias ls='lsd'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
