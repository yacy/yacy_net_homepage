# FreeBSD Install Guide

## Requirements

Next to Java YaCy requires bash and either wget or curl to work. These
are used for the scripts you find in ./bin. So we install those via pkg
or ports

    # Using pkg:
    pkg install openjdk curl bash

### Java Setup

Java requires proc and fd to be mounted. Make sure to append these lines
to /etc/fstab

    fdesc /dev/fd fdescfs rw 0 0
    proc /proc procfs rw 0 0

Then reboot or mount them manually for the changes to take effect.

## Install YaCy

For security reasons you should run YaCy as its own user. So you might
want to add a user called YaCy and switch to it.

    # As root:
    adduser
    Username: yacy
    ...
    # Switch to user yacy
    su - yacy

You need to download and extract the Linux version of YaCy. Luckily it
does not seem to be Linux specific at all.

    curl -o yacy.tar.gz http://release.yacy.net/release/yacy_latest.tar.gz 
    tar xzvf yacy_latest.tar.gz

That's it! You can now cd into directory and start YaCy.

    cd yacy
    ./startYACY.sh


## Use external Solr
If you want to use an external Solr instead of the build-in one, then:

* Install `textproc/apache-solr` port using:

	`pkg install apache-solr` or ports.
  
  Solr's database is located in `/var/db/solr`, in FreeBSD.

* Create Solr cores by following [External Solr guide](../dev/solr.md#create-search-cores).

* For Solr 9 you have to add line:

	`SOLR_MODULES=scripting`

  to `/usr/local/etc/solr.in.sh`, to enable XSLT. You can also tune some
  variables in that config file, such as max memory in `SOLR_HEAP` or
  address/port.

* Start-up Solr by:

	`service solr start`,

* and/or make it run on startup by adding:
	`solr_enable="YES"`
  to `/etc/rc.conf`.

* [Configure YaCy to use external solr](../dev/solr.md#setup-yacy-for-external-solr).


## Side notes for YaCy developers and advanced users

To make the installation easier `/usr/bin/env bash` in various scripts
should be replaced with `/usr/bin/env sh`. Bash doesn't seem to be
required for scripts to work, so this would remove an explicit
dependency. FreeBSD comes with ftp (which also supports http) and fetch,
which could theoretically be used in bin/apicall.sh. However the way the
password is sent (using MD5:...) appears to be causing problems. I was
not yet able to work around this. If this could be fixed curl/wget would
not be required.




_Converted from
<https://wiki.yacy.net/index.php?title=En:FreeBSDInstall>, may be
outdated_




