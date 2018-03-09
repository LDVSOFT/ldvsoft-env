# LDVSoft Environment Packages

There are some environment packages for me.

## Building

* Build package: `debuild -S -sa` in package folder.
* Upload package: `dput ppa:lapshin-dv/ppa *.changes` in root.

## Installing

* Apt: `sudo apt-add-repository ppa:lapshin-dv/ppa`.
* Install `ldvsoft-env-<...>` packages.
* Run `ldvsoft-env-<...>-install` to push required files and links.
