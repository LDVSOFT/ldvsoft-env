Usage context
=============

After installing nothing actually happens (other than maybe some helping scripts appear on `PATH`).
While many tools provide options for one-time use (you just provide an option pointing to a
configuration file), it's not convenient for creating a pleasant environment. Because of that, I
need to _enable_ configuration for given tool, and then it starts working (probably after reload
or restart of a tool).

Originally I've just copied or symlinked configuration to a discoverable location, but it didn't
cover all wanted cases.

Modes
-----

Configuration can be enabled in several ways.
* **System**-wide, for all users in the system.

  It's usually enabled by replacing system configuration file (if present) by a link to a file from
  the distribution.
* For a given **user** who directly uses tools.

  It's usually enabled by replacing user configuration file (if present) by a link to  a file from
  the distribution.
* Enable a user to be a **delegate**, so that when one user switches to another one (most prominent
  case would be `sudo`) configuration is still present.

  This will be a preferred method of enabling for shared machines, where you probably don't want
  every person using it to be forced into my environment.

Not all tools support all modes, but I expect everything to support system mode and user mode.
