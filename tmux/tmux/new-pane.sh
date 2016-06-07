#!/bin/bash
pane=$1
shift
path=$(tmux showenv "TMUX_PANE_${pane#%}_PATH" 2>/dev/null | sed 's/[^=]*=//')
tmux setenv TMUX_NEWPATH "${path}"
tmux "$@"
