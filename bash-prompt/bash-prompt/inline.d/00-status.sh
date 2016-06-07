if [ "${__prompt_last_exit}" == "0" ] ; then
	if [ -z "${__prompt_root}" ] ; then
		echo -n "${__prompt_clr_calm}(-_- 0)"
	else
		echo -n "${__prompt_clr_fg}{=_= 0}"
	fi
else
	echo -n "${__prompt_clr_error}[O_o ${__prompt_last_exit}]"
fi
