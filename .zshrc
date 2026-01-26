alias vi='vim'
alias pdb='python -m pdb'
alias irc='irssi'
alias airplay='pactl load-module module-raop-discover; sudo systemctl start avahi-daemon'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias tgpt="tgpt --provider sky --multiline"


source <(fzf --zsh)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#839496'
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH='/home/kevin/.local/bin':/usr/local/bin:$PATH
#Add in color for ls to see directories easier
export CLICOLOR=1
export CMAKE_GENERATOR=Ninja
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export EDITOR='vim'
export PATH="$HOME/.pyenv/bin:$PATH"

bindkey -e
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  alias ls="ls -G"
  #Enable forward searching in macos, as it interferes with XON/XOFF
  stty -ixon
  #disable print in terminal
  defaults write com.apple.terminal NSUserKeyEquivalents -dict-add "Print..." nil
  autoload edit-command-line
  zle -N edit-command-line
  bindkey '^X^E' edit-command-line
else
  alias ls="ls --color=auto"
fi

PROMPT="%F{cyan}%n%f%F{yellow}[%~]%f%F{cyan}%% "
#HistoryStuff
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups
setopt hist_ignore_space
setopt appendhistory
setopt sharehistory
#History
#Initialize pyenv, don't do it on open as it's kind of slow
penv() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}
#Screensavers
ss() {
  if (( RANDOM % 2 )); then
    cmatrix
  else
    asciiquarium
  fi
}
# ssh with fzf for config file as my ssh manager, thanks copilot
sshf() {
  local config="$HOME/.ssh/config"
  # Recursively expand config + includes
  _ssh_expand() {
    local file="$1"
    while IFS= read -r line || [[ -n "$line" ]]; do
      if [[ "$line" =~ ^[Ii]nclude[[:space:]]+(.*) ]]; then
        local includes=(${(z)match[1]})
        for inc in "${includes[@]}"; do
          eval "local expanded=\${(e)inc}"
          [[ "$expanded" != /* ]] && expanded="$(dirname "$file")/$expanded"
          for f in $~expanded; do
            [[ -f "$f" ]] && _ssh_expand "$f"
          done
        done
      else
        echo "$line"
      fi
    done < "$file"
  }
  # Build a list of hosts
  local entries
  entries=$(
    _ssh_expand "$config" \
    | awk '
      BEGIN { IGNORECASE=1 }
      /^Host[[:space:]]+/ {
        split($0, a, /[[:space:]]+/)
        aliases=""
        for (i=2; i<=NF; i++) if (a[i] !~ /\*/ && a[i] !~ /\?/) aliases=aliases" "a[i]
        if (aliases != "") {
          host_block=aliases
          hostname=""
          user=""
          inblock=1
        } else inblock=0
        next
      }
      inblock {
        if (tolower($1)=="hostname") hostname=$2
        if (tolower($1)=="user") user=$2
      }
      NF==0 && inblock {
        if (host_block!="") {
          if (hostname=="") hostname=host_block
          print host_block "|" hostname "|" user
        }
        inblock=0
      }
      END {
        if (inblock && host_block!="") {
          if (hostname=="") hostname=host_block
          print host_block "|" hostname "|" user
        }
      }
    '
  )
  [[ -z "$entries" ]] && { echo "No SSH hosts found"; return 1 }
  local pick
  pick=$(echo "$entries" \
    | column -t -s '|' \
    | fzf --prompt="SSH → " --height=40% --reverse --ansi) || return
  local alias
  alias=$(echo "$pick" | awk '{print $1}')

  print -z "ssh $alias"
}

