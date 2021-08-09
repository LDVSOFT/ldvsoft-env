LDVSoft environment distribution.
=================================

This is a distribution of LDVSoft environment configuration. To install it, invoke `./install` with
sufficient privileges. If you need some tweaks you can manually extract all directories into target
location (you don't need to extract this file and install script, of course). Please note that this
distribution can olny be installed at the location it was built for, see information below. Also,
some installation locations depend on environment variables, proceed with caution.

`mk-dist` info
--------------

> Distribution for **location** `@@LOCATION@@` (kind `@@LOCATION_KIND@@`).
> Expected **installation directory** is `@@DIST_LOCATION_PREFIX@@/`.
>
> **Packages** in this distribution: @@PACKAGES@@.
>
> Detailed locations:
>
> | Directory         | Distribution path | Installation path |
> | :---              | :---              | :---              |
> | _bindir_          | `@@BINDIR!DIST@@` | `@@BINDIR@@` |
> | _libdir_public_   | `@@LIBDIR_PUBLIC!DIST@@` | `@@LIBDIR_PUBLIC@@` |
> | _libdir_private_  | `@@LIBDIR_PRIVATE!DIST@@ `| `@@LIBDIR_PRIVATE@@` |
> | _execdir_public_  | `@@EXECDIR_PUBLIC!DIST@@`| `@@EXECDIR_PUBLIC@@` |
> | _execdir_private_ | `@@EXECDIR_PRIVATE!DIST@@` | `@@EXECDIR_PRIVATE@@` |
> | _datadir_private_ | `@@DATADIR_PRIVATE!DIST@@` | `@@DATADIR_PRIVATE@@` |
