if [ -f /usr/share/ldvsoft/bash-prompt/prompt.sh ] ; then
	. /usr/share/ldvsoft/bash-prompt/prompt.sh
else
	# Default prompt
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
	fi
	if [ -x /usr/bin/tput ] && (( `tput colors` >= 8 )) ; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	fi
fi
