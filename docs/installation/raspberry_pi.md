## Set up Raspberry Pi with YaCy

The [Raspberry Pi](http://www.raspberrypi.org/) ('RPi') is a
credit-card-sized single-board computer which can run Linux kernel-based
operating systems. We consider the usage of a 'Model B' with 512 MB
SDRAM. Since this computer consumes only 3.5 W it is an ideal plattform
for private 'cloud' applications and also to run a YaCy peer 24x7.

There is a wide range of [available operating systems for the
RPi](http://elinux.org/RPi_Distributions). There is also a 'default'
system recommended by the makers of the RPi, called "Raspbian" which is
based on debian wheezy.

There are several options for an OS on the Raspberry PI ('RPi'). We
consider to run YaCy on Raspbian but you might want to insert more
sections here for other OS'

### Running YaCy on Raspbian

We take the default Raspbian image but modify it to fit it for our
needs:

#### Preparation of Raspbian

  - Download the soft-float ABI version of Raspian called "wheezy-armel"
    from <http://www.raspberrypi.org/downloads>
  - Write the image to a SD card, a manual for Windows, Mac and Linux is
    at <http://elinux.org/RPi_Easy_SD_Card_Setup>
  - When the RPi starts up the first time, enable the ssh server in the
    Raspi-config menu and run expand-rootfs to use the full sd card
    capacity.
  - Log in to your RPi using ssh with the user 'pi' and the password
    'raspberry'.
  - Assign a [Static IP](staticip.md) to your RPi.
    This will cause that you have a unique link to your YaCy peer on the
    RPi in your intranet. If there is no conflict in the set-up of your
    network, use the default IP 192.168.1.70
  - Englarge swap space. It is not recommended to use a swap space on SD
    cards but java crashes if for any reason more memory is needed than
    we thought that is necessary. We will configure YaCy to take up only
    as much space so that swapping does not happen. But to protect YaCy
    from crashing, we enlarge the swap space:

<!-- end list -->

  - open the file /etc/dphys-swapfile and replace the '100' by i.e.
    '1024'. This will give you 1GB of swap space. This is available
    after a 'sudo dphys-swapfile setup' or a re-start.
  - to protect Raspbian from swapping (while still having the option) we
    need a low swappiness value. View the file /proc/sys/vm/swappiness
    and check that this is low. By default, there is a 1, you can
    replace it with a 0 with "sysctl -w vm.swappiness=0"

<!-- end list -->

  - Optional/recommended: update the RPi firmware, follow instructions
    in readme from <https://github.com/Hexxeh/rpi-update>
  - Optional/recommended: shrink Raspian with the [Headless
    Debian](shrink.md) tutorial by
    removing X11 and all dependencies. After this, you can also remove
    python and the Python Games on the RPi

<!-- end list -->

    rm -Rf ~/python_games
    sudo apt-get remove --purge python

.. followed by the same deborphan-process as described in [Headless
Debian](shrink.md)

  - Optional/recommended: remove all programming languages that you
    don't need when running YaCy:

<!-- end list -->

    sudo apt-get remove --purge python python2.6 python2.7 python3 python3.2 perl

You may want to remove orphan and not required packages after this using
the [Headless Debian](shrink.md)
tutorial again.

  - Optional/recommended: get latest system updates

<!-- end list -->

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade

followed by a restart

    sudo shutdown -r now

Repeat this until no updates appear. Then do a cleanup

    sudo apt-get clean

then you should have at most 627M used on your SD card:

    df -h .

#### Java Installation

  - primary option (recommended): install Oracle Headless JVM. This is
    probably the fastest JVM.

<!-- end list -->

  - Download a ARMv6/7 version from
    <http://www.oracle.com/technetwork/java/embedded/downloads/javase/index.html>
    - Java 1.6 is sufficient
  - copy the ejre\*.tar.gz file with scp to your RPi to ~pi/ i.e.

<!-- end list -->

    scp ejre-1_6_0_38-fcs-b05-linux-arm-vfp-eabi-headless-13_nov_2012.tar.gz pi@192.168.1.70:~/

  - untar the ejre\*.tar.gz file on your RPi, i.e.

<!-- end list -->

    sudo tar xfz ejre-1_6_0_38-fcs-b05-linux-arm-vfp-eabi-headless-13_nov_2012.tar.gz -C /usr/lib/

which creates a directory ejre1.6.0\_38 in /usr/lib. To add the java
command to the execution path, do

    sudo ln -s /usr/lib/ejre1.6.0_38/bin/java /usr/bin/java

  - alternative option: install OpenJDK. This works fine but is a much
    larger package and probably not as fast as the Oracle JVM. We need
    only the headless JRE. Simply do:

<!-- end list -->

    sudo apt-get install openjdk-7-jre-headless

  - To test if java is now available, run

<!-- end list -->

    java

  - **Note as of 09/11/2014** : an install on an ARM board (Olinuxino
    A13) proved that openjdk-7-jre-headless would not provide what is
    necessary to run the Java server as needed by Yacy, but would
    provide only a 'Zero VM' instead of a 'Server VM'. Hence at the
    moment installing the package from Java seems to be the only
    solution.

#### YaCy Installation

There is the option to install YaCy like any other debian package (see:
[Debian Installation](debianinstall.md)), but
then you cannot use the Oracle JVM as described above. We will just use
the YaCy tarball release.

  - install YaCy using a tarball from <https://release.yacy.net> i.e.

<!-- end list -->

    wget https://release.yacy.net/yacy_latest.tar.gz
    tar xfz yacy_latest.tar.gz

We should change some default settings in the yacy.init file (lower RAM
usage and lower disk space limit)

    sed "s/disk.free = 3000/disk.free = 1000/" -i ~/yacy/defaults/yacy.init
    sed "s/javastart_Xmx=Xmx600m/javastart_Xmx=Xmx120m/" -i ~/yacy/defaults/yacy.init

Now you can start YaCy:

    ~/yacy/startYACY.sh

  - If you set the default IP 192.168.1.70, then your YaCy peer will be
    available (wait a bit) at <http://192.168.1.70:8090>
  - YaCy will replace the default administration password, which is
    empty, after some minutes by a random password. You should set your
    own password by calling

<!-- end list -->

    ~/yacy/bin/passwd.sh {yournewpassword}

If you click on a protected page in YaCy, you must put in that password.

#### YaCy Auto-Start and Watchdog

We want that our RPi starts YaCy at boot time and shuts it down
properly. Create a file in /etc/init.d/yacy with the following content:

    #! /bin/sh
    ### BEGIN INIT INFO
    # Provides:          YaCy
    # Required-Start:    $local_fs $remote_fs $network $time
    # Required-Stop:     $local_fs $remote_fs $network $time
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: YaCy Search Engine
    ### END INIT INFO
    case "$1" in
     start)
      su - pi -c "/home/pi/yacy/startYACY.sh"
      ;;
     stop)
      su - pi -c "/home/pi/yacy/stopYACY.sh"
      ;;
     *)
      exit 3
      ;;
    esac
    :

and make it executable and linked with

    sudo chmod 755 /etc/init.d/yacy
    sudo update-rc.d yacy defaults

This will start and stop YaCy automatically. We also want that YaCy is
supervised with a watchdog and automatically restarted if it failed,
crashed or behaves dead. Add the following line to /etc/crontab

    0 * * * * pi cd /home/pi/yacy/bin && ./checkalive.sh

This will check and if necessary restart YaCy once an hour.

#### YaCy Search on (default http) Port 80

You need an iptables entry for that, just write the following line into
/etc/rc.local

    iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8090

Then your YaCy peer on the RPi is available at <http://192.168.1.70>





_Converted from <http://wiki.yacy.de/index.php?title=En:Raspberry_Pi>, may be
outdated_




