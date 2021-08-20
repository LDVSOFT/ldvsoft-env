# User runtime:
typeset user_configdir="${XDG_CONFIG_HOME:-${HOME}/.config}/@@PRIVATE_NAME@@"
typeset user_statedir="${XDG_STATE_HOME:-${HOME}/.local/state}/@@PRIVATE_NAME@@"
typeset user_cachedir="${XDG_CACHE_HOME:-${HOME}/.cache}/@@PRIVATE_NAME@@"
typeset user_runtimedir="${XDG_RUNTIME_DIR}/@@PRIVATE_NAME@@"

# System runtime:
typeset system_configdir="/etc/@@PRIVATE_NAME@@"
typeset system_statedir="/var/lib/@@PRIVATE_NAME@@"
typeset system_cachedir="/var/cache/@@PRIVATE_NAME@@"
typeset system_runtimedir="/run/@@PRIVATE_NAME@@"

# Lists:
typeset configs_locations=(
	"@@DATADIR_PRIVATE@@"
	"$system_configdir"
	# TODO: XDG_CONFIG_DIRS?
	"$user_configdir"
)
