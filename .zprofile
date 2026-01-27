export EMSDK_QUIET=1
source "$HOME/git/external/emsdk/emsdk_env.sh"
# Only start tmux if:
# - we're not already inside tmux
# - we're on a real TTY (not SSH, not subshell)
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    tmux new-session -A -s main
fi


