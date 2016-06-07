dirs=$(( $(dirs -p | wc -l) - 1))
if (( dirs == 0 )) ; then
	echo -n "${__prompt_clr_dark}[dirs 0]"
else
	echo -n "${__prompt_clr_fg}[dirs ${dirs}]"
fi
