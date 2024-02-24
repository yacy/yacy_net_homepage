# Arch Install Guide

YaCy has a [PKGBUILD in the
AUR](https://aur.archlinux.org/packages/yacy/) which greatly simplifies
installation. You can install this PKGBUILD with an AUR helper or by
hand.

## Installation

### Using an AUR Helper

If you are using a full-featured AUR helper like
[packer](https://aur.archlinux.org/packages/packer/),
[yaourt](https://aur.archlinux.org/packages/yaourt/), or another of that
ilk, you can run

    packer -S yacy

or

    yaourt -S yacy

. Adjust for your specific helper.

### By hand

First, ensure that you have installed all the dependencies;
specifically, you need `sudo`, `libcups`, `xorg-server`, and
`java-environment`. Install these with pacman. Once this is finished,
download and extract the PKGBUILD from the AUR. You can do this from
your web browser
([link](https://aur.archlinux.org/packages/ya/yacy/yacy.tar.gz)) and
extract it using your favorite GUI tool, or you can run the following
command:

    $ curl https://aur.archlinux.org/packages/ya/yacy/yacy.tar.gz | tar -xz

Now `cd` into the folder that the tarball extracted to (most likely
called "yacy") and run

    makepkg

. (Note: if you forgot to install the dependecies before, you should run
`makepkg -s`.) This will build us a nice .tar.xz package which `pacman`
knows how to handle. Once `makepkg` completes, install the package with
`pacman`:

    # pacman -U yacy-(YourVersion)-(YourArchitecture).tar.xz

(replace YourVersion and YourArchitecture with the current version and
your chip architecture (either i686 or x86\_64). Tab completion helps a
lot here.)

## Use

To actually start YaCy, you need to start its daemon with systemd:

    # systemctl start yacy.service

YaCy needs about a minute to initialize, bootstrap, and in general get
up and running. If you'd like the YaCy daemon to run automagically at
boot, enable its service with systemd:

    # systemctl enable yacy.service

You're all set! Don't forget to open your firewall or set up port
forwarding to contribute your index to the network!





_Converted from <https://wiki.yacy.net/index.php?title=En:ArchInstall>, may
be outdated_




