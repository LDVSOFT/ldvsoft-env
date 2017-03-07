#!/bin/bash

__prompt_source() {
	local file="$@"
	if [ -f "${file}" ] ; then
		source "${file}"
	fi
}

__prompt_newline () {
	export __prompt_line_id=$(( __prompt_line_id + 1 ))
	if (( __prompt_line_id == 1 )) ; then
		echo -n "${__prompt_clr}┬"
	else
		echo
		echo -n "${__prompt_clr}├"
	fi
}

__prompt () {
	export __prompt_last_exit=$?
	export __prompt_line_id=0
	export __prompt_width=$(tput cols)

	# tmux integration
	if [ ! -z "${TMUX}" ] ; then
		__prompt_source "${__prompt_path}/../tmux/at-prompt.sh"
	fi

	local need=
	__prompt_newline
	for f in $(find "${__prompt_path}/inline.d/" -type f -name '*.sh' | sort) ; do
		if [ ! -z "${need}" ] ; then
			echo -n "${__prompt_sep}"
		fi
		source "$f"
		if (( "$?" == 0 )) ; then
			need=y
		else
			need=
		fi
		echo -n "${__prompt_reset}"
	done

	local need=y
	for f in $(find "${__prompt_path}/line.d/" -type f -name '*.sh' | sort) ; do
		if [ ! -z "${need}" ] ; then
			__prompt_newline
		fi
		source "$f"
		if (( "$?" == 0 )) ; then
			need=y
		else
			need=
		fi
		echo -n "${__prompt_reset}"
	done

	if [ ! -z "${__prompt_title}" ] ; then
		echo -n "${__prompt_title_enter}bash: $(whoami)@$(hostname) $(pwd)${__prompt_title_leave}"
	fi
		
	echo
}

__prompt_setup () {
	export __prompt_path=$(dirname $(readlink -f "$BASH_SOURCE"))

	local symbol='$'
	if [ "$(whoami)" == "root" ] ; then
		export __prompt_root=y
		symbol='#'
	fi
	
	source "${__prompt_path}/prompt-utils.sh"

	export __prompt_title=
	if tput hs ; then
		export __prompt_title=y
		export __prompt_title_enter=$(tput tsl)
		export __prompt_title_leave=$(tput fsl)
	fi

	export __prompt_reset=$(echo -e '\e[0m')
	export __prompt_bold=$(tput bold)

	local color_file=""
	case "$(tput colors)" in
		8|88|256)
			color_file="8colors.sh" ;;
	esac
	if [ ! -z "${color_file}" ] ; then
		source "${__prompt_path}/${color_file}"
		__prompt_source "/etc/ldvsoft-env/bash-prompt/${color_file}"
		__prompt_source "${HOME}/.ldvsoft-env/bash-prompt/${color_file}"
	fi
	
	# this one is in bash format
	export __prompt_sep="${__prompt_clr}──"
	export PROMPT_COMMAND='__prompt'
	export PS1="\[${__prompt_clr}\]╰\[${__prompt_clr_fg}\]${symbol}\[${__prompt_reset}\] "
}

__prompt_setup
