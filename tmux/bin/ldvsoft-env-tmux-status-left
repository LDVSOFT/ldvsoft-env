#!/bin/bash
pane=${1#%}
orig="fg=default,bg=default,$(tmux show -gqv status-style),$(tmux show -gqv status-left-style)"
tmux show-environment "TMUX_PANE_${pane}_USERHOST" 2>/dev/null | sed 's/^[^=]*=//' | tr -d '\n'
if (( "$2" == 1 )) ; then
	echo -n " #[bg=blue,fg=yellow,bold][*]#[${orig}]"
fi
