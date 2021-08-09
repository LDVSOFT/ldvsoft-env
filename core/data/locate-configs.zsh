function locate-files {
	setopt LOCAL_OPTIONS NULL_GLOB

	local locations=(${(P)1}) # pass array name
	local what_glob=$2

	local -A files

	for d ( $locations ) {
		# Dot qualifier: must be a regular file.
		d_glob=$d/$what_glob(.)
		for f ( ${~d_glob} ) {
			files[${f:t}]=$f
		}
	}

	reply=()
	for f ( ${(ik)files} ) {
		reply+=${files[$f]}
	}
}

function locate-configs {
	local config_dirs=('@@DATADIR_PRIVATE@@' $system_configdir $user_configdir) # TODO: maybe XDG_CONFIG_DIRS in the middle?
	locate-files config_dirs $1
}

function source-configs {
	local reply
	locate-configs $1
	for f ( $reply ) { source $f }
}
