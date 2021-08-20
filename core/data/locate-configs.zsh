function locate-files {
	setopt LOCAL_OPTIONS NULL_GLOB

	local locations=(${(P)1}) # pass array name
	shift
	local what_globs=($@)

	local -A files

	for d ( $locations ) {
		for what_glob ( $what_globs ) {
			# Dot qualifier: must be a regular file.
			d_glob=$d/$what_glob(.)
			for f ( ${~d_glob} ) {
				files[${f:t:r}]=$f
			}
		}
	}

	reply=()
	for f ( ${(ik)files} ) {
		reply+=${files[$f]}
	}
}

function locate-configs {
	locate-files configs_locations $@
}

function source-configs {
	local reply
	locate-configs $@
	for f ( $reply ) { source $f }
}
