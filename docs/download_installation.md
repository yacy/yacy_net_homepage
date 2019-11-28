# Download and Installation of YaCy

YaCy is available as packages for Windows, Macintosh and Debian. You can also install YaCy on any other operation system using a tarball. YaCy needs Java 8; we recommend to run Openjdk 8.

<p><a class="btn btn-default btn-sm pull-right" href="https://github.com/yacy/yacy_net_homepage/blob/master/docs/download_installation.md" role="button" target="_blank">Improve this doc</a>
</p>

## Download

YaCy is free software - licensed under GPL-2. We provide downloads free of charge, but we ask for a donation:

<div class="container">
      <div class="row">
        <div class="col-md-4" style="background-color:#4E5D6C; margin-right:15px; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h3>Private User</h3>
          <p>Please donate a small one-time fee</p><br/>
<form target="_blank" action="https://www.paypal.com/cgi-bin/webscr" method="post" style="margin:0px; padding:0px;">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="on0" value="Your contribution is received as a taxable, legal payment.">
<img src="../img/pp-logo-100px.png">&nbsp;
<input type="radio" name="os0" value="beneficial">&nbsp;5 &euro;&nbsp;
<input type="radio" name="os0" value="generous" checked>&nbsp;25 &euro;&nbsp;
<input type="radio" name="os0" value="gracious">&nbsp;50 &euro;&nbsp;
<input type="hidden" name="currency_code" value="EUR">
<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
<input class="btn btn-success btn-sm" type="submit" name="submit" value="Donate">
</form><br/>
        </div>
        <div class="col-md-4" style="background-color:#4E5D6C; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h3>Commercial Users</h3>
          <p>..Universities and generous private users:<br/>please subscribe to</p>
<a href="https://github.com/users/Orbiter/sponsorship" target="_blank"><img src="https://yacy.net/images/logo-mona-100.png" width="32" height="32"></a>
<a href="https://github.com/users/Orbiter/sponsorship" target="_blank">Github Sponsors</a>
or
<a href="https://www.patreon.com/0rb1t3r" target="_blank"><img src="https://yacy.net/images/become_a_patron_button.png" width="120"></a><br/><br/>
        </div>
      </div>
</div>

You may also download and try out YaCy first and come back later to donate. Please help!

### Linux: Generic Tarball
[http://latest.yacy.net/yacy_v1.922_20191013_9964.tar.gz](http://latest.yacy.net/yacy_v1.922_20191013_9964.tar.gz)

### Windows Installer
[http://latest.yacy.net/yacy_v1.922_20191014_9966.exe](http://latest.yacy.net/yacy_v1.922_20191014_9966.exe)

### Mac Application
[http://latest.yacy.net/yacy_v1.922_20191013_9964.dmg](http://latest.yacy.net/yacy_v1.922_20191013_9964.dmg)

<!--
### Debian Package
Our packages are released at [http://debian.yacy.net/](http://debian.yacy.net/).
Please see the instructions below for the installation process.
-->

### Get the Source Code
The source code is inside the generic tarball. We recommend that you clone our git repository at
[https://github.com/yacy/yacy_search_server](https://github.com/yacy/yacy_search_server)

### Development builds
Automatic builds can be obtained from
[http://latest.yacy.net/](http://latest.yacy.net/)

## Installation

This is an easy process and everyone should be able to do this. Windows and Macintosh users should be able to install YaCy in the same way as they install any other application.

### On Linux and any other Operation Systems
If you know how to install Java on your computer and how to start a shell script, the process is very simple:

* Install JDK 8 (Oracle or OpenJDK)
* Download and decompress the tarball
* Run `startYACY.sh` inside your decompressed folder

This can be done by running in a terminal:

```
sudo apt-get update
sudo dpkg --configure -a
sudo apt-get install -y openjdk-8-jdk
wget http://latest.yacy.net/yacy_v1.922_20191013_9964.tar.gz
tar xfz http://latest.yacy.net/yacy_v1.922_20191013_9964.tar.gz
cd yacy
./startYACY.sh
```

* YaCy is then running on port 8090; i.e. open [http://localhost:8090](http://localhost:8090) in your browser
* no password is required when accessing this YaCy instance from localhost
* for headless operation, set the password on the host console with `bin/passwd.sh <password>`

### On Windows

* Install Java 8 from [https://adoptopenjdk.net/](https://adoptopenjdk.net/)
* Install YaCy by double-clicking the downloaded installer
* When the message "Windows protected your PC (in Windows 10) appears, click "More info", then "Run anyway". When asked "Do you want to allow this app from an unknown publisher to make changes to your device", click "yes".
* Within the YaCy Installer, click "Next", "I Agree", "Next", "Install", "Finish"
* To run YaCy, just double-click the YaCy App Icon (which may be on your desktop)
* YaCy is then running on port 8090; i.e. open [http://localhost:8090](http://localhost:8090) in your browser

### On Macintosh

* Install Java 8 from [https://adoptopenjdk.net/](https://adoptopenjdk.net/)
* Double-click the downloaded `.dmg`-File and copy the YaCy App out of the mounted drive into your Application folder
* To run YaCy, just double-click the YaCy App Icon in your Application Folder
* YaCy is then running on port 8090; i.e. open [http://localhost:8090](http://localhost:8090) in your browser

### Compile YaCy yourself

You can download and build your own YaCy with these simple steps. You need:

* jdk-8 installed (Oracle Java 8 or OpenJDK 8)
* ant
* git

then do:

```
git clone https://github.com/yacy/yacy_search_server.git
cd yacy_search_server
ant clean all dist
```
The compiled tarball in then in the `RELEASE` folder.

<!--
### Debian Packages

Installation on Debian-based GNU/Linux operating systems is easy using our Debian repository:

```
http://debian.yacy.net
```

Become root (i.e. with `sudo su -`) and create a debian source list file for YaCy sources:

```
echo 'deb http://debian.yacy.net ./' > /etc/apt/sources.list.d/yacy.list 
```

Install the developer key with one of the two next methods

```
wget http://debian.yacy.net/yacy_orbiter_key.asc -O- | apt-key add -
apt-key advanced --keyserver pgp.net.nz --recv-keys 03D886E7
```

And finally install YaCy itself. 

```
apt-get update
apt-get install openjdk-8-jre-headless # java 8 is required, only a headless version is needed
apt-get install yacy
```

YaCy is running now on port 8090 and you can access it with  [http://localhost:8090](http://localhost:8090)


#### Important File Locations

After installation, the yacy application path is:

```
/usr/share/yacy
```

The DATA-path is:

```
/var/lib/yacy
```

The configuration files should be here:

```
/etc/yacy/
```

`/etc/yacy/yacy.conf` is created using the `/usr/share/yacy/defaults/yacy.init` file on the first run.

The log files should be here:

```
/var/log/yacy/
```

#### Managing YaCy
When you have installed YaCy using the Debian repository, YaCy is started automatically after your OS has started, and is stopped before shutdown. You can also start and stop YaCy from the command line with: (must be run as root)

```
/etc/init.d/yacy stop
/etc/init.d/yacy start
/etc/init.d/yacy restart
```

You can use systemctl (run as root) to enable or disable YaCy automatic startup at boot.

Enable automatic startup :

```
systemctl enable yacy
```

Disable automatic startup :

```
systemctl disable yacy
```

The YaCy web server runs on port 8090 by default. The administration pages are at `http://localhost:8090/`
but you can also set any other port for the interface using the administration pages of YaCy. A Port 80 is possible, but it is better to get access to this port using a Portforwarding.

#### Changing password
If you do not set a username and password during installation, the username will be "admin" and the password will be randomly generated. You can still run a yacy node this way, but it won't have the potential to be as useful since you won't be able to change password-protected settings. Access the password-protected parts by changing the password manually in a terminal. You can do this by going to /usr/share/yacy/bin and running "./passwd.sh <new password>" (Note: your new password will appear in plain text in the terminal).

```
cd /usr/share/yacy/bin
./passwd.sh <new password>
```

#### Automatic Updates
When configured this way, the YaCy-internal auto-updater does not work. An automatic update must be done with OS tools. i.e. with a crontab command. An example for that is the following line, which you must write into `/etc/crontab`

```
0 6 * * * root apt-get update && apt-get -y --force-yes install yacy
```

In Ubuntu, the above line is only valid for the system crontab file (located at /etc/crontab) - you can edit this file on newer Ubuntu OS directly without using the crontab command. Below are comments from the file in Ubuntu 12.04:

```
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.
```

If you want to use the root user crontab in Ubuntu instead, an example would be:

```
username@hostname:~$ sudo crontab -e 
no crontab for root - using an empty one

Select an editor.  To change later, run 'select-editor'.
 1. /bin/ed
 2. /bin/nano        <---- easiest
 3. /usr/bin/vim.basic

Choose 1-3 [2]: <enter>
```

Then add the following at the end of the file:

```
0 6 * * * /usr/bin/apt-get update && /usr/bin/apt-get -y --force-yes install yacy
```

Please note, there is no user name on the line above, and absolute (full) paths are used here to prevent binary location problems!
-->
