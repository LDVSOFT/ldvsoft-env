#!/bin/bash

if ! git branch >/dev/null 2>/dev/null ; then
	return 1
fi

local branch=
local upstream=
local path=
local ahead=0
local behind=0
local untracked=0
local changed=0
local staged=0
local conflicts=0
local stashed=0

local gitstatus=$(git status --porcelain --branch -u)
local branch_line=
path="/$(git rev-parse --show-prefix | sed 's|/$||g')"
local gitdir="$(git rev-parse --git-dir)"

while IFS='' read -r line ; do
	local status=${line:0:2}
	case "${status}" in
		\#\#)  branch_line=$(echo "${line}" | sed -e 's/^## //g' -e 's/\.\.\./@/g') ;;
		?M|?D) ((changed++))   ;;
		U?)    ((conflicts++)) ;;
		\?\?)  ((untracked++)) ;;
		*)     ((staged++))    ;;
	esac
done <<< "${gitstatus}"

stashed=$(git stash list | wc -l)

__prompt_git_read() {
	local f="$1" ; shift
	[ -r "$f" ] && read "$@" <"$f"
}

local state=
local branch_=
local step=
local total=
# based on git's `contrib/completion/git-prompt.sh'
if [ -d "${gitdir}/rebase-merge" ] ; then
	if [ -f "${gitdir}/rebase-merge/interactive" ] ; then
		state='rebase -i'
	else
		state='rebase -m'
	fi
	__prompt_git_read "${gitdir}/rebase-merge/head-name" branch_
	__prompt_git_read "${gitdir}/rebase-merge/msgnum" step
	__prompt_git_read "${gitdir}/rebase-merge/end" total
elif [ -d "${gitdir}/rebase-apply" ] ; then
	if [ -f "${gitdir}/rebase-apply/rebasing" ] ; then
		__prompt_git_read "${gitdir}/rebase-apply/head-name" branch_
		state='rebase'
	elif [ -f "${gitdir}/rebase-apply/applying" ] ; then
		state='am'
	else
		state='rebase/am'
	fi
	__prompt_git_read "${gitdir}/rebase-apply/next" step
	__prompt_git_read "${gitdir}/rebase-apply/last" total
elif [ -f "${gitdir}/MERGE_HEAD" ] ; then
	state='merge'
elif [ -f "${gitdir}/CHERRY_PICK_HEAD" ] ; then
	state='cherry-pick'
elif [ -f "${gitdir}/REVERT_HEAD" ] ; then
	state='revert'
elif [ -f "${gitdir}/BISECT_LOG" ] ; then
	state='bisect'
fi

local fields=

IFS='@' read -ra fields <<< "${branch_line}"
branch=${fields[0]}
if [[ "${branch}" = *"Initial commit on"* ]] ; then
	IFS=' ' read -ra fields <<< "${branch}"
	branch=${fileds[3]}
elif [[ "${branch}" = *"HEAD"* ]] ; then
	local tag=$(git describe --tags --exact-match 2> /dev/null)
	if [ -n "${tag}" ] ; then
		branch="(tag ${tag})"
	else
		branch="#$(git rev-parse --short HEAD)"
	fi
else
	if (( ${#fields[@]} != 1 )) ; then
		IFS='[,]' read -ra fields <<< "${fields[@]}"
		upstream=${fields[0]}
		local remote_field=
		for remote_field in "${fields[@]}" ; do
			case "${remote_field}" in
				*ahead*)  ahead=${remote_field:6}  ;;
				*behind*) behind=${remote_field:7} ;;
			esac
		done
	fi
fi

if [ ! -z "${upstream}" ] ; then
	read -ra fields <<< "${upstream}"
	upstream=${fields[1]}
	upstream=$(echo "${upstream}" | sed "s|/${branch}$||g")
fi

local clr=${__prompt_clr_fg}
if [ ! -z "${state}" ] ; then
	clr=${__prompt_clr_standout}
	if [ ! -z "${step}" -o -z "${total}" ] ; then
		state=" ${state}:${step}/${total}"
	else
		state=" ${state}"
	fi

	if [ ! -z "${branch_}" ] ; then
		state="${state} on ${branch_}"
	fi
fi
echo -n "${clr}[Git${state}]${__prompt_sep}${__prompt_clr_fg}${branch}"
if [ ! -z "${upstream}" ] ; then
	local clr=${__prompt_clr_fg}
	if (( ahead + behind != 0 )) ; then
		if (( behind == 0 )) ; then
			clr=${__prompt_clr_success}
		elif (( ahead == 0 )) ; then
			clr=${__prompt_clr_standout}
		else
			clr=${__prompt_clr_warn}
		fi
	fi
	echo -n "${__prompt_sep}${clr}${upstream}"
	if (( behind != 0 )) ; then
		echo -n "▾${behind}"
	fi
	if (( ahead != 0 )) ; then
		echo -n "▴${ahead}"
	fi
fi
if (( untracked + changed + staged + conflicts != 0 )) ; then
	local clr=${__prompt_clr_warn}
	if (( conflicts != 0 )) ; then
		clr=${__prompt_clr_error}
	elif (( changed + untracked == 0 )) ; then
		clr=${__prompt_clr_success}
	fi
	echo -n "${__prompt_sep}${clr}"
	if (( untracked != 0 )) ; then
		echo -n "?${untracked}"
	fi
	if (( changed != 0 )) ; then
		echo -n "+${changed}"
	fi
	if (( staged != 0 )) ; then
		echo -n "✔ ${staged}"
	fi
	if (( conflicts != 0 )) ; then
		echo -n "✘ ${conflicts}"
	fi
fi

if (( stashed != 0 )) ; then
	echo -n "${__prompt_sep}${__prompt_clr_fg}[stash ${stashed}]"
fi

echo -n "${__prompt_sep}${__prompt_clr_path}"
__prompt_print_path "${path}"
