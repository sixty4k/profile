My Bash Profile
===============

Grabbed from https://github.com/matschaffer/profile, and slowly but surely ripped to pieces from there.

Installation
------------
On a brand new mac, to set things up the way *Mike* wants things, try this:

    curl -O https://raw.githubusercontent.com/sixty4k/profile/master/bin/rebuild_mac.sh && bash ./rebuild_mac.sh

    curl -s https://raw.githubusercontent.com/sixty4k/profile/master/install | bash

From here you can now put any `*.conf` in `~/.profile.d` and it'll get loaded in alphabetical order. You can also make directories that end in `.conf` which profile will then load all the `.conf` files in that directory in order.

Load order
----------

This profile loads `init` first, followed by all the `.conf` files in `.profile.d/core`, then any `.conf` files in `.profile.d`. This way you can put any general use configs in `core` and anything personal in `.profile.d`. If you want to keep your personal profile information in git, just set up `core` as a submodule to your personal repository.

Features
--------
