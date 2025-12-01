#cat .logo
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#export PATH="/usr/local/bin:$PATH"
export "CFLAGS=-I/usr/local/include -L/usr/local/lib"
export XDG_CONFIG_HOME="$HOME/.config"

LS_COLORS=$LS_COLORS:'di=42;1;37:' ; export LS_COLORS;

#Setting foreground background colors of R output
NVIM_TUI_ENABLE_TRUE_COLOR=1

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="narota"
ZSH_THEME="gentoo2"
#ZSH_THEME="robbyrussell"
DEFAULT_USER="$USER"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    archlinux
    autojump
    chucknorris
    docker
    docker-compose
    git
    git-flow
    golang
    history-substring-search
    mercurial
    pip
    python
    rbenv
    ruby
    systemd
    virtualenv
 )

source $ZSH/oh-my-zsh.sh

# User configuration

setopt appendhistory
setopt extendedhistory
setopt incappendhistory
setopt histfindnodups
setopt sharehistory

bindkey '\C-P' history-substring-search-up
bindkey '\C-N' history-substring-search-down

autoload -U compinit
compinit

case "${TERM}" in
  xterm*)
    export TERM=xterm-256color
    cache_term_colors=256
    if [[ -f "/usr/bin/dircolors" ]] ; then
      eval "`dircolors -b`"
    fi
    alias ls='ls --color=auto'
    ;;
  screen)
    cache_term_colors=256
    if [[ -f "/usr/bin/dircolors" ]] ; then
      eval "`dircolors -b`"
    fi
    alias ls='ls --color=auto'
    ;;
  dumb)
    cache_term_colors=2
    ;;
  *)
    cache_term_colors=16
    if [[ -f "/usr/bin/dircolors" ]] ; then
      eval "`dircolors -b`"
    fi
    alias ls='ls --color=auto'
    ;;
esac

if [[ -f "/usr/bin/dircolors" ]] && [[ -f ${HOME}/.dircolors ]] && [[ ${cache_term_colors} -ge 8 ]] ; then
  eval $(dircolors -b ${HOME}/.dircolors)
fi


PATH="${PATH}:${HOME}/bin"

if [[ -d "$HOME/bin" ]]; then
  PATH="${PATH}:${HOME}/bin"
fi

if [[ -d "$HOME/src/bin" ]]; then
  PATH="${HOME}/src/bin:${PATH}"
fi

if [[ -d "/usr/lib/ccache/bin" ]]; then
  PATH="/usr/lib/ccache/bin:${PATH}"
fi
if [[ -d "/usr/lib/distcc/bin" ]]; then
  PATH="/usr/lib/distcc/bin:${PATH}"
  DISTCC_HOSTS="@buttercup.local/4"
fi

if [[ -d "$HOME/go/bin" ]]; then
  export GOPATH=$HOME/go
  PATH="${HOME}/go/bin:${PATH}"
fi

if [[ -d "$HOME/node/bin" ]]; then
  export NODE_PATH=$HOME/node
  PATH="${HOME}/node/bin:${PATH}"
fi

if [[ -d "/usr/lib/smlnj/bin" ]]; then
  PATH="/usr/lib/smlnj/bin:${PATH}"
fi

if [[ -d "/usr/local/bin" ]]; then
  PATH="/usr/local/bin:${PATH}"
fi


if [[ -d "/usr/local/opt/python@3.7/bin" ]]; then
  PATH="/usr/local/opt/python@3.7/bin:${PATH}"
fi

if [[ -f /usr/bin/keychain ]]; then
    /usr/bin/keychain ~/.ssh/id_rsa
    source ~/.keychain/$HOST-sh
    source ~/.keychain/$HOST-sh-gpg
fi

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [[ -d "$HOME/.rbenv/bin" ]]; then
    PATH=$PATH:$HOME/.rbenv/bin
    eval "$(rbenv init -)"
fi

export WORKON_HOME="$HOME/.envs"
export EDITOR=vim
#export MAKEFLAGS="-j$(grep processor /proc/cpuinfo | wc -l)"
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
if [[ -f /opt/homebrew/bin/virtualenvwrapper.sh ]]; then
    source /opt/homebrew/bin/virtualenvwrapper.sh
fi

alias pygrep="grep --include='*.py' $*"
alias rbgrep="grep --include='*.rb' $*"
alias csgrep="grep --include='*.cs' $*"

alias dmesg="dmesg -L"
# some more ls aliases
# di: directory
# ln: synlinks
LS_COLORS=$LS_COLORS:'di=42;1;37:ln=0;36' ; export LS_COLORS
alias ll='ls -lhG'
alias la='ls -AG'
alias ls='ls -AG'
alias ldir='ls -lhA |grep ^d'
alias lfiles='ls -lhA |grep ^-'
alias l='ls -CF'
alias lc='ls -G'

# To check a process is running in a box with a heavy load: pss
alias pss='ps -ef | grep $1'

# usefull alias to browse your filesystem for heavy usage quickly
alias ducks='sudo du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

alias c='clear'
alias up='cd ..'

alias radeondynpm='echo dynpm | sudo tee -a /sys/class/drm/card0/device/power_method'
alias radeonprofile='echo profile | sudo tee -a /sys/class/drm/card0/device/power_method'
alias radeonlow='echo low | sudo tee -a /sys/class/drm/card0/device/power_profile'
alias radeonmid='echo mid| sudo tee -a /sys/class/drm/card0/device/power_profile'
alias radeondefault='echo default | sudo tee -a /sys/class/drm/card0/device/power_profile'
alias radeonhigh='echo high | sudo tee -a /sys/class/drm/card0/device/power_profile'
alias drmdebug='echo 14 | sudo tee -a /sys/module/drm/parameters/debug'
alias drmnodebug='echo 0 | sudo tee -a /sys/module/drm/parameters/debug'

alias resrc='source ~/.zshrc'
alias ondemand='sudo cpupower frequency-set -g ondemand'
alias powersave='sudo cpupower frequency-set -g powersave'
alias performance='sudo cpupower frequency-set -g performance'
alias notify='notify-send -i gnome-terminal "[$?] $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alert$//'\'')"'

alias tma='tmux attach -d -t'

alias drm='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images -q)'
alias drmv='docker volume rm $(docker volume ls -q)'

cleanvim() {
    echo "Cleaning ~/.vimbackup/"
    rm -Rf ~/.vimbackup/*
    echo "Cleaning ~/.vimswap/"
    rm -Rf ~/.vimswap/*
    echo "Cleaning ~/.vimviews/"
    rm -Rf ~/.vimviews/*
    echo "Cleaning ~/.vimundo/"
    rm -Rf ~/.vimundo/*
    echo "All done!"
}

unset GREP_OPTIONS
alias grep='grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn'
alias npm-exec='PATH=$(npm bin):$PATH'
#alias set_remote_ssh_login = ""
# export rednose
export NOSE_REDNOSE=1

if [ -f ~/base16-shell/scripts/base16-brewer.sh ]; then
    source ~/base16-shell/scripts/base16-brewer.sh;
fi

# load aws ssh
if [[ -f $HOME/.narota/aws.sh ]]; then
    #source ~/.zshrc.local
    source $HOME/.narota/aws.sh
fi

#zshell in vim mode
#bindkey -v
export KEYTIMEOUT=1 # escape key time to 0.1 second

#load develtoolset4
if [[ -f /opt/eh/develtoolset4/enable ]]; then
    source /opt/rh/devtoolset-4/enable
fi

if [[ -f ~/.narota/scripts.sh ]]; then
    source ~/.narota/scripts.sh
fi

if [[ -f ~/.narota/base16-gruvbox.dark.sh ]]; then
    source ~/.narota/base16-gruvbox.dark.sh
fi

if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=011'
    bindkey '^ ' autosuggest-accept
fi
if [[ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=011'
    bindkey '^ ' autosuggest-accept
fi

# tmuxinator
if [[ -f ~/.zsh/tmuxinator/completion/tmuxinator.zsh ]]; then
    source ~/.zsh/tmuxinator/completion/tmuxinator.zsh
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

export PATH="${HOME}/local/bin:/usr/local/opt/openssl@1.1/bin:$PATH"

# added by travis gem
[ ! -s /Users/anarota/.travis/travis.sh ] || source /Users/anarota/.travis/travis.sh


if [[ -d "/usr/local/bin" ]]; then
  PATH="/usr/local/bin:${PATH}"
fi

# kubectk
source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell

# groovy
if [[ -d "/usr/local/opt/groovy/" ]]; then
  GROOVY_HOME="/usr/local/opt/groovy/libexec"
fi

complete -o nospace -C /usr/local/bin/vault vault

# vault
VAULT_ADDR=https://vault.truveris.com:8200

complete -o nospace -C /usr/local/Cellar/tfenv/2.0.0/versions/0.13.3/terraform terraform

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/narota/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/narota/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/narota/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/narota/google-cloud-sdk/completion.zsh.inc'; fi

# JAVA HOME
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"


if [[ -d "$HOME/.zshrc.local" ]]; then
  source $HOME/.zshrc.local
fi
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"