Pluggable configuration
=======================

When dealing with huge configuration files, one will usually need to add, remove, or reword a bit.
Because of that, using a huge default configuration file in the end causes problems. While one can 
try to write an ideal configuration file with everything being tunable, in the end this only 
delegates a problem to those parameters.

Instead, it's a good idea to split configuration into pieces, so that you can overwrite one piece 
fully without affecting others. When combined with several locations for those files, you can truly
create layered configuration where every next level adjust previous one.

I was inspired by `systemd` configuration system.

Layers
------

Most basic tools use single configuration layer (and nothing if it's missing). That's a boring 
story. More advanced tools use single configuration layer, but they search for two locations: user
one and system one (that is used as a default when user has nothing). While it's basic, user files
can pull system ones, and things become a bit interesting.

Common tools use two layers: system one and user one, where user layer can override some things in 
system one. While for some usages enforcing something at system layer not to be changed by anyone in
user layer, it's not needed for my environment.

Most advanced tools use a _lot_ of layers. `systemd` user units use **16** layers.

Configuration file
------------------

When using pluggable configuration, main configuration file is just a driver to load all right 
pieces. While some tools (like shells) are powerful enough to run a driver natively, other tools
(like `tmux`) will not like the idea of running a loop of files.

Because of