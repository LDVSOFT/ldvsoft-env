Directories specification
=========================

While I'd love to have those configs in their original form used in any suitable way, sometimes
they require references to other files or even themselves. While some files, like shell scripts,
can use some blood magic get their location in system and reference other files relative to that,
some files can't do that. Because of that, I need to embed installation locations into those files
for every installation option. To achieve that, I am recreating a part of autotools preprocessor
shenanigans so that my “source” files can use special `@@VARIABLE@@` variables that will be
replaced with appropriate paths in “distribution” files. Those distributions can't be installed in
other locations.

Installation directories
------------------------

My packages provide some executable helpers (mostly scripts), configuration files, drop-ins, etc.
To follow FHS-like standards (including [systemd file hierarchy][systemd-fhs] & [XDG Base
Directories][xdg-basedirs]), I split installation locations into several directories:

* `bindir`: commands directory, for executable binaries & scripts locatable on `PATH`;
* `execdir`: executables directory, for executable binaries not on `PATH`;
* `libdir`: libraries for executables, usually architecture-dependant or for given language runtime;
  * For architecture-dependant files you should add an architecture identifier;
  * The location itself is considered «public», for example you put public shared objects there. For
    private libraries, you should add scope identifier (usually a package name in shared location).
* `datadir`: data directory, for architecture-independent mostly read-only files.
* _(there might be more in the future, like man pages, etc.)_

There are several options regarding some of those locations:
* For `execdir` and `libdir`, if a file is architecture-dependant (in case you have a binary), you
  can add architecture identifier (like in `/lib/i386-linux-gnu`) and put files there, so that
  multi-architecture installations are possible. Modern systems mostly require that for `libdir`,
  not so much for `execdir`. I don't need any binary files right now.
* For public directories, all files placed directly into those are in public scope. For example,
  shared objects in public `libdir` are available for dynamic linker out of the box. It's good for
  libraries, not as good for something private. Choose public names wisely, add a path stem for
  private scoping.  Do remember that some scopes are already in public use, I wouldn't call
  `/usr/lib/python3.9` a private location.
  * `bindir`, because of its usage, can't have a private subdirectory.
  * Public `datadir`, on the other hard, is not used directly at all.
  * Since Debian forbids using `lib` for architecture-independent files (actually they allow if
    there is a mix of dependent and independent files), for now I put library-like scripts into
    data.

Expressions
-----------

One important point here is that if you'd simply implement those locations with string substitution,
you'd get some options but not all of them:
* For user locations, that would embed username and their home directory path into the distribution.
  Barely reusable.
* XDG environment variables…

Because of that, embedding path information requires a little more that just a string literal. While
I can just provide a helper script, if a tool can invoke programs from its configuration files it
probably already can deal with environment variables and users' home directories. By the way, how
would one lookup where this script is located?

For now, paths should support simple environment variables expansion. Some more options maybe to
come:
* `~` expansion, instead of `$HOME`.
* Defaults for environments, like bash / zsh `${varVame-defaultWord}` (maybe with a colon).

> As an alternative, I can translate variable lookups into native config languages, but embedding
> all that into installations seems harder that it's worth.

Installation locations
----------------------

Those directories depend on installation location. All paths below should be considered shell (bash
or zsh) expressions, with `~` expanding to home directory of a user and `${}` being substitutions of
environment variables, optionally with modifiers.

* **System** — system-wide locations.
  * **Root**, for essential parts of an operating system. Should be used only for packages
    integrated with the system, usually by being installed from a package manager.

    | Directory | Public | Private |
    | --- | --- | --- |
    | `bindir` | `/bin` | |
    | `execdir` | `/libexec/` | `/libexec/⟨package-name⟩` |
    | `libdir` | `/lib` | `/lib/⟨package-name⟩` |
    | `datadir` |  | `/share/⟨package-name⟩` |
  * **Usr**, for non-essential parts of an operating system. Should be used only for packages
    integrated with the system, usually by being installed from a package manager.

    | Directory | Public | Private |
    | --- | --- | --- |
    | `bindir` | `/usr/bin` | |
    | `execdir` | `/usr/libexec/` | `/usr/libexec/⟨package-name⟩` |
    | `libdir` | `/usr/lib` | `/usr/lib/⟨package-name⟩` |
    | `datadir` |  | `/usr/share/⟨package-name⟩` |
    Please note that modern systems merge `/usr` & `/` paths (in favor of first ones) and symlinks
    are used for compatability. GNU recommended merging in the opposite way.
  * **Local**, for unmanaged packages which still integrate with an operating system. Recommended
    for locally built packages.

    | Directory | Public | Private |
    | --- | --- | --- |
    | `bindir` | `/usr/local/bin` | |
    | `execdir` | `/usr/local/libexec/` | `/usr/local/libexec/⟨package-name⟩` |
    | `libdir` | `/usr/local/lib` | `/usr/local/lib/⟨package-name⟩` |
    | `datadir` |  | `/usr/local/share/⟨package-name⟩` |
  * **Opt**, for packages that do not integrate into system and are usually installed into a single
    directory. For example, default PATH with most likely not include those locations.

    | Directory | Public | Private |
    | --- | --- | --- |
    | `bindir` | `/opt/⟨package-name⟩/bin` | |
    | `execdir` | `/opt/⟨package-name⟩/libexec/` | `/opt/⟨package-name⟩/libexec/private` |
    | `libdir` | `/opt/⟨package-name⟩/lib` | `/opt/⟨package-name⟩/lib/private` |
    | `datadir` |  | `/opt/⟨package-name⟩/share/` |
* **User** — user-local location. It still can be used by other users, but there are two concerns:
  1. Privacy: user with an installed package must provide access to the installation location;
  1. Trust: user who wants to use the package must trust the user who installed it.
  * **X Desktop Group**, for user packages integrated with an operating system.

    | Directory | Public | Private |
    | --- | --- | --- |
    | `bindir` | `~/.local/bin` | |
    | `execdir` | `~/.local/libexec` | `~/.local/libexec/⟨package-name⟩` |
    | `libdir` | `~/.local/lib` | `~/.local/lib/⟨package-name⟩` |
    | `datadir` |  | `${XDG_DATA_HOME:-~/.local/share}/⟨package-name⟩` |

    There is a tricky point here that `XDG_DATA_HOME` environment variables affects the location.
    This is especially bad when implementing delegates (see [usage contexts](usage.md)).
  * **Local**, for user packages integrated with an operating system, however we ignore the
    `XDG_DATA_HOME` customization.

    | Directory | Public | Private |
        | --- | --- | --- |
    | `bindir` | `~/.local/bin` | |
    | `execdir` | `~/.local/libexec` | `~/.local/libexec/⟨package-name⟩` |
    | `libdir` | `~/.local/lib` | `~/.local/lib/⟨package-name⟩` |
    | `datadir` |  | `${XDG_DATA_HOME:-~/.local/share}/⟨package-name⟩` |

    There is a tricky point here that `XDG_DATA_HOME` environment variables affects the location.
  * **Opt**, for user packages not integrated with an operating system.

    | Directory | Public | Private |
    | --- | --- | --- |
    | `bindir` | `~/.local/opt/⟨package-name⟩/bin` | |
    | `execdir` | `~/.local/opt/⟨package-name⟩/libexec/` | `~/.local/opt/⟨package-name⟩/libexec/private` |
    | `libdir` | `~/.local/opt/⟨package-name⟩/lib` | `~/.local/opt/⟨package-name⟩/lib/private` |
    | `datadir` |  | `~/.local/opt/⟨package-name⟩/share/` |
* **Custom single-directory** — _opt_-like single-directory installation location.

  | Directory | Public | Private |
  | --- | --- | --- |
  | `bindir` | `⟨custom-prefix⟩/bin` | |
  | `execdir` | `⟨custom-prefix⟩/libexec/` | `⟨custom-prefix⟩/libexec/private` |
  | `libdir` | `⟨custom-prefix⟩/lib` | `⟨custom-prefix⟩/lib/private` |
  | `datadir` |  | `⟨custom-prefix⟩/share/` |

Variables
---------

| Variable | Type | Description |
| --- | --- | --- |
| `BINDIR` | Path, variable expression | Public `bindir` installation location. |
| `EXECDIR_PUBLIC` | Path, variable expression | Public `execdir` installation location. |
| `EXECDIR_PRIVATE` | Path, variable expression | Private `execdir` installation location. |
| `LIBDIR_PUBLIC` | Path, variable expression | Public `libdir` installation location. |
| `LIBDIR_PRIVATE` | Path, variable expression | Private `libdir` installation location. |
| `DATADIR_PRIVATE` | Path, variable expression | Private `datadir` installation location. |
| `PRIVATE_NAME` | Path stem, string | Name of private scope for runtime usage. |

Runtime directories
-------------------

Independent of the installation location, while running, my utilities will sometimes need to read or
write state, read some bits of configuration, etc. Since I assume only user-targeted experience
(while allowing system-wide usage by everyone), there is no need for system-only configuration.

Those directories are:
* `configdir`: configuration files directory, usually utilities only read those.
* `statedir`: state storage directory, usually read and written by utilities.
* `cachedir`: cache storage directory, usually managed by utilities.
* `runtimedir`: runtime-only directory, for files (including special ones) only relevant on current
  session or system boot.

For every that location, there is a system location, user one and (optionally) additional ones:

| Directory | System location | User location | Additional locations |
| --- | --- | --- | --- |
| `configdir` | `/etc` | `~/.config` | _see XDG note_ |
| `statedir` | `/var/lib` | `~/.local/state` | |
| `cachedir` | `/var/cache` | `~/.cache` | |
| `runtimedir` | `/run` | _see XDG note_ | |

On how one should use those locations together, take a look at [configuration documentation](
configuration.md).

> XDG base directories specifies that:
> 1. User configuration location can be changed via `$XDG_CONFIG_HOME`.
> 1. Additional configuration should be looked up in `$XDG_CONFIG_DIRS`.
> 1. User runtime directory is specified via environment variable.
> Right now I don't support those fully.

[systemd-fhs]: https://www.freedesktop.org/software/systemd/man/file-hierarchy.html
[xdg-basedirs]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
