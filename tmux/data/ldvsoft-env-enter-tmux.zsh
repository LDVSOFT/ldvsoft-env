source-configs 'tmux/options.zsh'

session=${1:-${default_session:-main}}
exec tmux new-session -A -s $session
