# LDVSoft Environment Packages

There are some environment packages for me.

## Building

* Build package: `debuild -S -sa -pgpg2` in package folder.
* Upload package: `dput -u ppa:lapshin-dv/ppa *.changes` in root (**WARNING**: `-u` only added because `dput` has no option to use `gpg2`).
