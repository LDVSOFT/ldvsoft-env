#!/bin/bash
tmux setenv "TMUX_PANE_${TMUX_PANE#%}_PATH" "$(pwd)"
