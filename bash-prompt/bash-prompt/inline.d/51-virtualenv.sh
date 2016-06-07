if [ -z "${VIRTUAL_ENV}" ] ; then
	return 1
fi

echo -n "${__prompt_clr_fg}[virtualenv `basename ${VIRTUAL_ENV}`]"
