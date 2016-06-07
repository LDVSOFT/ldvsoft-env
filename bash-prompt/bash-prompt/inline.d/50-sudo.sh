if [ ! -z "${__prompt_root}" ] ; then
	return 1
fi
if sudo -n true 2>/dev/null ; then
	echo -n "${__prompt_clr_warn}[sudo on ]"
else
	echo -n "${__prompt_clr_dark}[sudo off]"
fi
