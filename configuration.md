Pluggable configuration
=======================

When dealing with huge configuration files, one will usually need to add, remove, or reword a bit.
Because of that, using a huge default configuration file in the end causes problems. While one can
try to write an ideal configuration file with everything being tunable, in the end this only
delegates a problem to those parameters.

Instead, it's a good idea to split configuration into pieces, so that you can overwrite one piece
fully without affecting others. When combined with several locations for those files, you can truly
create layered configuration where every next level adjust previous one to your needs.

I was inspired by `systemd` configuration system, however mine is way more basic.

Layers
------

Most basic tools use single configuration layer (i.e. only one file, or nothing if it's missing).
That's a boring story. More advanced tools use single configuration layer, but they search for two
locations: user one and system one (that is used as a default when user has nothing). While it's
quite basic, user files can sometimes pull system ones, and things become a bit interesting.

Some tools use two layers: system one and user one, where user layer can override some things in
system one. While for some problems there might be need to enforce some options at the system layer
so that they aren't changeable in anyone's user layer, it's not needed for my environment.

If you are using layered configuration you can provide defaults as third, default, layer. I use this
too.

Most advanced tools use a _lot_ of layers. `systemd` user units use **16** layers.

Separate files
--------------

Writing all the things in a single file is hard to combine with extensibility. When you want just to
add something or change one little thing without affecting all others, it's hard to do when your
only options are:
* Append lines into existing configuration,
* When using layers, copy previous layer and tweak it a bit.

Many tools already recognize with as a problem, so they provide `include`-like statements that pull
contents of other specified files, or in a best-case scenario provide an option to read a whole
directory. What that means is you now get an option to split configuration in somewhat-independent
pieces and only replace needed pieces.

While great, this doesn't provide an option for layering pieces of configuration on its own. To 
achieve that, I apply the same method that `systemd` does: instead of loading layers sequentially,
files of all layers are listed, and for each file name a file from the latest layer is taken. After
that all files are loaded in a sorted order. The method allows splitting configuration into ordered
pieces and then only change several pieces in a next layer.

> Drop-ins
> --------
>
> To achieve even better result `systemd` allows instead of overriding the whole file drop a small
> file into special directory, and those files would be merged with underlying configuration. Not
> implemented for now, since most useful results are already achievable with separate files.
>
> `systemd` does that because the whole configuration of a unit must be a single file.

Configuration file
------------------

When using pluggable configuration, main configuration file is just a driver to load all the right
pieces. It doesn't do anything beyond that.

> Caching could be an option for faster loads.

External Drivers
----------------

While some tools (like shells) are powerful enough to run a driver natively, other tools (like
`tmux`) don't like the idea of running a loop to search the right files. Because of that I need an
external script that enumerates configuration files to load or even generates the actual single file
to be used.
