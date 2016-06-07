pane=${TMUX_PANE#%}
tmux setenv "TMUX_PANE_${pane}_USERHOST" "${USER}@$(hostname)"
