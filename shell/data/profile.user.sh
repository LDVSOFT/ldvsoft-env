# LDVSoft environment: login shell configuration.

# Mostly we set here environment variables. The problem, however, is that profile files allow
# arbitrary command execution, and some people would prefer not to spend startup time on those.
# There already are replacements, like systemd environment.d files & generators, but their usage is
# quite limited. On the other hand, profile files are exactly used for that. For now just get sure
# that your system properly sources those (I look at you, Gnome Wayland Session).

if [ "${BASH-}" || "${ZSH_NAME-}" ] ; then
	source "@@DATADIR_PRIVATE@@/profile.user.goodsh"
else
	echo '=== LDVSOFT ENV DISCLAIMER ===' >&2
	echo '| LDVSoft env expects to be running a pretty good shell.' >&2
	echo '| Supported shells are bash and zsh, but this shell is not one of those!' >&2
	echo '| For your own sanity, please fix your setup!' >&2
	echo '| INITIALIZATION HAS BEEN CANCELED.' >&2
	echo '|' >&2
	echo '| Login/user shell name:' ${SHELL:-'(not given?!)'} >&2
	echo '| Program name (might be a copy/link to another shell):' $0 >&2
	echo -n '| Self ps: ' >&2
	"`which ps`" -wwp $$ '-oargs=' '-ocomm=' >&2 || echo "(ps failed, code: $?)" >&2
	[ -f "/proc/$$/exe" ] && { echo -n '| Self exe: ' >&2 ; readlink /proc/$$/exe ; }
	echo '=== LDVSOFT ENV DISCLAIMER OVER ===' >&2
fi

if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi
