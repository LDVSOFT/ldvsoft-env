# LDVSoft Environment Packages

There are some environment packages for me.

## Building

* Build package: `debuild -S -sa -pgpg2` in package folder.
* Upload package: `dput -u ppa:lapshin-dv/ppa *.changes` in root (**WARNING**: `-u` only added because `dput` has no option to use `gpg2`).

## Installing

* Apt: `sudo apt-add-repository ppa:lapshin-dv/ppa`.
* Install `ldvsoft-env-<...>` packages.
* Run `ldvsoft-env-<...>-install` to push required files and links.
