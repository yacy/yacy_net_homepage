# Installation of YaCy on Debian

Installation on Debian-based GNU/Linux operating systems is easy using
our Debian repository:

    http://debian.yacy.net

**TODO: not any more!**

Create a debian source list file for YaCy sources:

    echo 'deb http://debian.yacy.net ./' > /etc/apt/sources.list.d/yacy.list 

Install the developer key with one of the two next methods

    wget http://debian.yacy.net/yacy_orbiter_key.asc -O- | apt-key add -
    apt-key advanced --keyserver pgp.net.nz --recv-keys 03D886E7

And finally install YaCy itself. **Warning\!** If you will be using Tor,
it is important to read
[YaCy and Tor](../operation/yacy-tor.md) before taking
the next step\! Tor must be configured for YaCy before YaCy runs for the
time. Running "apt-get install yacy" before setting up Tor will create a
state for which there is no documentation to recover from.

    apt-get update
    apt-get install openjdk-7-jre-headless # java 7 is sufficient, only a headless version is needed
    apt-get install yacy

## Important File Locations

After the installation, the yacy application path is:

    /usr/share/yacy

The DATA-path is:

    /var/lib/yacy

The configuration files should be here:

    /etc/yacy/

/etc/yacy/yacy.conf is created using the
/usr/share/yacy/defaults/yacy.init file on the first run.

The log files should be here:

    /var/log/yacy/

## Managing YaCy

When you have installed YaCy using the Debian repository, YaCy is
started automatically after a OS startup, and stopped before shutdown.

You can also start and stop YaCy from the command line with: (must be
run as root)

    /etc/init.d/yacy stop
    /etc/init.d/yacy start
    /etc/init.d/yacy restart

You can use systemctl (run as root) to enable or disable YaCy automatic
startup at boot.

Enable automatic startup :

    systemctl enable yacy

Disable automatic startup :

    systemctl disable yacy

The YaCy web server runs on port 8090 by default. The administration
pages are at

    http://localhost:8090/

but you can also set any other port for the interface using the
administration pages of YaCy. A Port 80 is possible, but it is better to
get access to this port using a
[Portforwarding](../operation/portforwarding.md).

**Changing password**: If you do not set a username and password during
installation, the username will be "admin" and the password will be
randomly generated. You can still run a yacy node this way, but it won't
have the potential to be as useful since you won't be able to change
password-protected settings. Access the password-protected parts by
changing the password manually in a terminal. You can do this by going
to /usr/share/yacy/bin and running `./passwd.sh <new password>` (Note:
your new password will appear in plain text in the terminal).

    cd /usr/share/yacy/bin
    ./passwd.sh <new password>

## Automatic Updates

When configured this way, the YaCy-internal auto-updater does not work.
An automatic update must be done with OS tools. i.e. with a crontab
command. An example for that is the following line, which you must write
into /etc/crontab

    0 6 * * * root apt-get update && apt-get -y --force-yes install yacy

In Ubuntu, the above line is only valid for the system crontab file
(located at /etc/crontab) - you can edit this file on newer Ubuntu OS
directly without using the crontab command. Below are comments from the
file in Ubuntu 12.04:

    # /etc/crontab: system-wide crontab
    # Unlike any other crontab you don't have to run the `crontab'
    # command to install the new version when you edit this file
    # and files in /etc/cron.d. These files also have username fields,
    # that none of the other crontabs do.

If you want to use the **root user** crontab in Ubuntu instead, an
example would be:

    username@hostname:~$ sudo crontab -e 
    no crontab for root - using an empty one
    
    Select an editor.  To change later, run 'select-editor'.
     1. /bin/ed
     2. /bin/nano        <---- easiest
     3. /usr/bin/vim.basic
    
    Choose 1-3 [2]: <enter>

Then add the following at the end of the file:

    0 6 * * * /usr/bin/apt-get update && /usr/bin/apt-get -y --force-yes install yacy

Please note, there is no user name on the line above, and absolute
(full) paths are used here to prevent binary location problems\!

## Next Steps

After you configured YaCy, you may also want to set a [static
IP](staticip.md) to get a unique IP to your YaCy
peer.





_Converted from
<http://wiki.yacy.net/index.php?title=En:DebianInstall>, may be outdated_




