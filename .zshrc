#Shortcut to ssh into my linux box
#alias nucbuntu="ssh kevin@10.0.10.5" wireless
#alias nucbuntu="ssh kevin@10.0.10.85" #wired old
alias nucbuntu="ssh kevin@10.0.10.194" #wired
alias skywalker="ssh root@10.0.10.1" #openwrt
alias spiderman="ssh root@10.0.10.186" #openmediavault
alias ldb='lua -e "require(\"mobdebug\").listen()"'
alias pdb='python -m pdb'
export PATH=/usr/local/bin:$PATH
#Initialize pyenv for python environments
eval "$(pyenv init -)"
#Allow better history between tmux panes/windows
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
#Add in color for ls to see directories easier
alias ls='ls -G'
export CLICOLOR=1
#Enable forward searching in macos, as it interferes with XON/XOFF
stty -ixon
#modify the zsh shell prompt
PS1="%n@%m %1~%F{cyan}%#%f "
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#disable print in terminal
defaults write com.apple.terminal NSUserKeyEquivalents -dict-add "Print..." nil
#Used so that we use ninja by default
export CMAKE_GENERATOR=Ninja
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export LUA_PATH="$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua;;"
export LUA_CPATH="$HOME/.luarocks/lib/lua/5.4/?.so;;"
export EDITOR='vi'
bindkey -e
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line


