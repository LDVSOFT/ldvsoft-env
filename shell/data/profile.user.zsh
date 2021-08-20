function {
	source "@@DATADIR_PRIVATE@@/runtime-directories.zsh"
	source "@@DATADIR_PRIVATE@@/locate-configs.zsh"

	source-configs 'profile.user.d/*.sh' 'profile.user.d/*.zsh'
}
