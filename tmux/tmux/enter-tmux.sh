if [ -z "${TMUX}" ] ; then
	tmux attach || tmux new
	exit
else
	path=$(tmux showenv TMUX_NEWPATH 2>/dev/null | sed 's/[^=]*=//')
	if [ ! -z "${path}" ] ; then
		cd "${path}"
	fi
	source /usr/share/ldvsoft/tmux/setup-status.sh
fi
