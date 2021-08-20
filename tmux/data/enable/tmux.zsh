for dep ( @@DEPENDENCIES@@ ) {
	check-dependency $dep
}

case $install_mode in
user)
	install_link @@DATADIR_PRIVATE@@/tmux.conf ~/.tmux.conf
	;;
system)
	install_link @@DATADIR_PRIVATE@@/tmux.conf /etc/tmux.conf
	;;
user-delegate)
	error Delegation not supported. >&2
esac
