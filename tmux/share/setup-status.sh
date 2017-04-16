#!/bin/bash
tmux setenv "TMUX_PANE_${TMUX_PANE#%}_USERHOST" "${USER}@$(hostname)"
