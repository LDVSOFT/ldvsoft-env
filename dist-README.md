# LDVSoft environment distribution.

This is a distribution of LDVSoft environment configuration. To install it, extract all directories
(you don't need this file and install script) into target location or just invoke `./install`
script. Please note that this distribution can only be installed at the exact location it was built
for, see the paths below.

## `mk-dist` info

> **Packages:** @@PACKAGES@@.
>
> Distribution for **location** `@@LOCATION@@` (kind `@@LOCATION_KIND@@`).
> Expected **installation directory** is `@@DIST_TARGET_PREFIX@@`.
>
> Directories:
>
> | Directory         | Private? | Path |
> | ---               | ---      | ---  |
> | _bindir_          | No       | `@@BINDIR@@` |
> | _libdir_public_   | No       | `@@LIBDIR_PUBLIC@@` |
> | _libdir_private_  | Yes      | `@@LIBDIR_PRIVATE@@` |
> | _execdir_public_  | No       | `@@EXECDIR_PUBLIC@@` |
> | _execdir_private_ | Yes      | `@@EXECDIR_PRIVATE@@` |
> | _datadir_private_ | Yes      | `@@DATADIR_PRIVATE@@` |
