#Shortcut to ssh into my linux box
#alias nucbuntu="ssh kevin@10.0.10.5" wireless
#alias nucbuntu="ssh kevin@10.0.10.85" #wired old
alias nucbuntu="ssh kevin@10.0.10.194" #wired
alias skywalker="ssh root@10.0.10.1" #openwrt
alias spiderman="ssh root@10.0.10.186" #openmediavault
alias vi='vim' #openmediavault
alias ldb='lua -e "require(\"mobdebug\").listen()"'
alias pdb='python -m pdb'
alias mpp='ncmpcpp'
alias irc='irssi'
export PATH='/home/kevin/.local/bin':/usr/local/bin:$PATH
#Initialize pyenv for python environments
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#Allow better history between tmux panes/windows
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
#Add in color for ls to see directories easier
alias ls='ls -G' #mac
alias ls='ls --color=auto' #linux
alias airplay='pactl load-module module-raop-discover'
export CLICOLOR=1
#Enable forward searching in macos, as it interferes with XON/XOFF
stty -ixon
#modify the zsh shell prompt
# PS1="%n@%m %1~%F{cyan}%#%f "
# PROMPT="%n@%m %1~%F{cyan}%#%f "
PROMPT="%F{cyan}%n%f%F{yellow}[%~]%f%F{cyan}%% "
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#disable print in terminal
#defaults write com.apple.terminal NSUserKeyEquivalents -dict-add "Print..." nil
#Used so that we use ninja by default
export CMAKE_GENERATOR=Ninja
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export LUA_PATH="$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua;;"
export LUA_CPATH="$HOME/.luarocks/lib/lua/5.4/?.so;;"
export EDITOR='vim'
bindkey -e
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt sharehistory
setopt histignoredups
setopt histignorespace
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#839496'

alias gcam='git commit -am'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
source <(fzf --zsh)
alias loff='hyprctl keyword monitor "eDP-1, disable"'
alias lon='hyprctl keyword monitor "eDP-1, preferred, auto, auto"'
ss() {
  if (( RANDOM % 2 )); then
    cmatrix
  else
    asciiquarium
  fi
}
