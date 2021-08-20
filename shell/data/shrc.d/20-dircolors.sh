if [ -x /usr/bin/dircolors ] ; then
	if [ -r ~/.dircolors ] ; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b "@@DATADIR_PRIVATE@@/dir_colors")"
	fi
fi
