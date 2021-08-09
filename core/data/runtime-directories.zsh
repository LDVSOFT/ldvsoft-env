# User runtime:
user_configdir="${XDG_CONFIG_HOME:-${HOME}/.config}/@@PRIVATE_NAME@@"
user_statedir="${XDG_STATE_HOME:-${HOME}/.local/state}/@@PRIVATE_NAME@@"
user_cachedir="${XDG_CACHE_HOME:-${HOME}/.cache}/@@PRIVATE_NAME@@"
user_runtimedir="${XDG_RUNTIME_DIR}/@@PRIVATE_NAME@@"

# System runtime:
system_configdir="/etc/@@PRIVATE_NAME@@"
system_statedir="/var/lib/@@PRIVATE_NAME@@"
system_cachedir="/var/cache/@@PRIVATE_NAME@@"
system_runtimedir="/run/@@PRIVATE_NAME@@"
