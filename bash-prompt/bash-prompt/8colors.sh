export __prompt_clr_fg="${__prompt_reset}"
export __prompt_clr_standout="${__prompt_clr_fg}$(tput bold)"

if [ -z "${__prompt_root}" ] ; then
	export __prompt_clr="${__prompt_reset}"
	export __prompt_clr_username="$(tput setaf 2; tput bold)"
else
	export __prompt_clr="${__prompt_reset}$(tput setaf 1)"
	export __prompt_clr_username="${__prompt_clr}$(tput bold)"
fi

export __prompt_clr_dark="${__prompt_reset}$(tput setaf 8)"
export __prompt_clr_path="${__prompt_reset}$(tput setaf 4; tput bold)"
export __prompt_clr_error="${__prompt_reset}$(tput setaf 1; tput bold)"
export __prompt_clr_warn="${__prompt_reset}$(tput setaf 11; tput bold)"
export __prompt_clr_success="${__prompt_reset}$(tput setaf 2; tput bold)"
export __prompt_clr_calm="$(tput setaf 4)"
