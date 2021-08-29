function error {
	echo 'Error:' $@ >&2
	exit 1
}

function _log {
	local level=$1
	local name=$2
	shift 2
	if (( ${debug-0} < level )) { return }
	echo "[${(r:5:)name}]" $@ >&2
}

function log-info {
	_log 1 Info $@
}

function log-debug {
	_log 2 Debug $@
}

function warning {
	if [[ -v strict ]] {
		error $@
	} else {
		echo 'Warning:' $@ >&2
	}
}

function {
	local metas=($sourcedir/*/meta.zsh(.))
	all_packages=(${metas:h:t})
}

# Fills variables with metadata of given package.
# Arg 1: source directory.
# Arg 2: package.
#
# Will set variables 'name', 'description', 'dependencies' and 'replacements' in outer scope.
# 'replacements' must be already declared and be an array.
function source-meta {
	local package=$1

	unset name
	unset description
	typeset -g dependencies=()
	typeset -gA external_dependencies=()
	function add-replacement {
		replacements+=(s:@@$1@@:$2:g)
	}

	source $sourcedir/$package/meta.zsh

	unfunction add-replacement

	if [[ $p != core ]] {
		dependencies+=(core)
	}

	: ${name=$package}
}
