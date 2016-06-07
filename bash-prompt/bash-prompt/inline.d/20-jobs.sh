local jobs_cnt=$(jobs -p | wc -l)
if (( ${jobs_cnt} == 0 )) ; then
	echo -n "${__prompt_clr_dark}[jobs 0]"
else
	echo -n "${__prompt_clr_fg}[jobs ${jobs_cnt}]"
fi
