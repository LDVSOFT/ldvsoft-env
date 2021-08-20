for dep ( @@DEPENDENCIES@@ ) {
	check-dependency $dep
}

if [[ ! ( $SHELL = **/bin/bash || $SHELL = **/bin/zsh ) ]] {
	echo '=== DISCLAIMER ===' >&2
}

case $install_mode in
user)
	install_link @@DATADIR_PRIVATE@@/profile.user.sh ~/.profile
system)
	error Cannot enable shell package system-wide.
user-delegate)
	error Delegation not supported. >&2
esac
