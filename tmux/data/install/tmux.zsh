case $install_mode in
user)
	install_link @@DATADIR_PRIVATE@@/tmux.conf ~/.tmux.conf
	;;
system)
	install_link @@DATADIR_PRIVATE@@/tmux.conf /etc/tmux.conf
	;;
user-delegate)
	echo Delegation not supported. >&2
	exit 1
esac