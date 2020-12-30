# Download and Installation of YaCy


YaCy is available as packages for Windows, Macintosh and Debian. You can also install YaCy on any other operation system using a tarball. YaCy needs Java 8, OpenJDK 8 is recommended.

<p><a class="btn btn-default btn-sm pull-right" href="https://github.com/yacy/yacy_net_homepage/blob/master/docs/download_installation.md" role="button" target="_blank">Improve this doc</a>
</p>

## Please Support YaCy

YaCy is libre software - licensed GPL-2+. Downloads are provided free, with the option to donate:

<div class="container">
      <div class="row">
        <div class="col-md-4" style="background-color:#4E5D6C; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h3>Become a YaCy Patron</h3>
with <a href="https://www.patreon.com/0rb1t3r" target="_blank"><img src="https://yacy.net/images/become_a_patron_button.png" width="120"></a><br/>
or
<a href="https://github.com/users/Orbiter/sponsorship" target="_blank"><img src="https://yacy.net/images/logo-mona-100.png" width="32" height="32"></a>
<a href="https://github.com/users/Orbiter/sponsorship" target="_blank">GitHub Sponsors</a></br>
        </div>
        <div class="col-md-4" style="background-color:#4E5D6C; margin-right:15px; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h3>One-Time Donation</h3>
<form target="_blank" action="https://www.paypal.com/cgi-bin/webscr" method="post" style="margin:0px; padding:0px;">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="on0" value="Your contribution is happily received as a tax-deductable, legal payment.">
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
      </div>
</div>


You may also download and try out YaCy first and come back later to donate. Please help!

## Installation

Installation is very easy on any system. If it looks complex here it's just because we give directions in great detail.

### YaCy for Windows

* *IMPORTANT* Install Java 8 from [https://adoptopenjdk.net/](https://adoptopenjdk.net/) *first*.
* <a class="btn btn-success btn" href="https://download.yacy.net/yacy_v1.924_20201214_10042.exe" role="button">Download YaCy for Windows</a> from [https://download.yacy.net/yacy_v1.924_20201214_10042.exe](https://download.yacy.net/yacy_v1.924_20201214_10042.exe)
* Install YaCy by double-clicking the downloaded installer.
* When the message "Windows protected your PC (in Windows 10) appears, klick "More info", then "Run anyway". When asked "Do you want to allow this app from an unknown publisher to make changes to your device", klick "yes".
* Within the YaCy Installer, klick "Next", "I Agree", "Next", "Install", "Finish".
* To run YaCy, double-click the YaCy app icon (which may be on your desktop).
* Whenever the following dialog appears click "allow private networks" and "allow access"
![Windows Java Security Setting](img/win_java_security_dialog.png){: width="400"}
* YaCy is then running on port 8090 on your machine. Open [http://localhost:8090](http://localhost:8090) in your web-browser.


### YaCy for Linux and other OS
You must install Java 8 on your computer if you don't have it already, and start the YaCy start shell script.
YaCy can run under a normal user account, no root rights are needed if Java 8 is already installed.

* Install JDK 8 (Oracle or preferably OpenJDK). You get Java for Linux from [https://adoptopenjdk.net/](https://adoptopenjdk.net/) but you should follow the installer package system that comes with your linux distribution.
* <a class="btn btn-success btn" href="https://download.yacy.net/yacy_v1.924_20201214_10042.tar.gz" role="button">Download generic YaCy</a> from [https://download.yacy.net/yacy_v1.924_20201214_10042.tar.gz](https://download.yacy.net/yacy_v1.924_20201214_10042.tar.gz), i.e. by

* Unpack the tarball.
* Run `startYACY.sh` inside your decompressed folder.
```
wget https://download.yacy.net/yacy_v1.924_20201214_10042.tar.gz
```

This can be done by running in a terminal:

```
sudo apt-get update
sudo dpkg --configure -a
sudo apt-get install -y openjdk-8-jre-headless
wget https://download.yacy.net/yacy_v1.924_20201214_10042.tar.gz
tar xfz yacy_v1.924_20201214_10042.tar.gz
cd yacy
./startYACY.sh
```

* YaCy is now running on port 8090 on your machine. Open [http://localhost:8090](http://localhost:8090) in your web-browser.
* No password is required when accessing this YaCy instance from localhost.
* Headless operation can be achieved by setting a password on the host console with `bin/passwd.sh <password>`.


### Docker ###

Just run
```
docker run -d --name yacy -p 8090:8090 -p 8443:8443 yacy/yacy_search_server
```
then open http://localhost:8090

The default login for YaCy on docker is `admin`:`yacy` 


### On Macintosh

* Install Java 8 from [https://adoptopenjdk.net/](https://adoptopenjdk.net/).
* <a class="btn btn-success btn" href="https://download.yacy.net/yacy_v1.924_20201214_10042.dmg" role="button">Download YaCy for MacOS</a> from [https://download.yacy.net/yacy_v1.924_20201214_10042.dmg](https://download.yacy.net/yacy_v1.924_20201214_10042.dmg)
* Double-click the downloaded `.dmg`-file and copy the YaCy app out of the mounted drive into your "Application" folder.
* To run YaCy, just double-click the YaCy app icon in your "Application" folder.
* YaCy is then running on port 8090 on your machine. Open [http://localhost:8090](http://localhost:8090) in your web-browser.


### Any OS with Java 8
Automatic development builds can be obtained from
[https://download.yacy.net/](https://download.yacy.net/).


### Get the Source Code
The source code is inside the generic tarball. It is recommended you clone the Git repository at
[https://github.com/yacy/yacy_search_server](https://github.com/yacy/yacy_search_server).
### Compile YaCy yourself

You can download and build your own YaCy with these simple steps. You need:

* jdk-8 installed (Oracle Java 8 or OpenJDK 8)
* ant
* git

Then run:
```
git clone https://github.com/yacy/yacy_search_server.git
cd yacy_search_server
ant clean all dist
```
The compiled tarball will then be in the `RELEASE` folder.

To start YaCy from your compiled code, simply run:
```
./startYACY.sh
```

<!--
### Debian Package
Our packages are released at [http://debian.yacy.net/](http://debian.yacy.net/).
Please see the instructions below for the installation process.
-->
<!--
### Debian Packages

Install YaCy on Debian-based GNU/Linux operating systems using our repository:

```
http://debian.yacy.net
```

Become root (i.e. with `sudo su -`) and create a Debian source list file for YaCy sources:

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

YaCy is now running on port 8090 on your machine, and you can access it with [http://localhost:8090](http://localhost:8090).


#### Important File Locations

After the installation, the YaCy application path is:

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
Having installed YaCy using the Debian repository, YaCy is started automatically following a OS startup, and stopped before shutdown. You can also start and stop YaCy as root from the command line with:

```
/etc/init.d/yacy stop
/etc/init.d/yacy start
/etc/init.d/yacy restart
```

You can use systemctl as root to turn on or off automatic YaCy startup upon booting.

Automatic startup :

```
systemctl enable yacy
```

Turn off automatic startup:

```
systemctl disable yacy
```

The YaCy web server runs on port 8090 by default. The administration landing page is at `http://localhost:8090/`
but you can also assign any other port to the interface using the administration pages in YaCy. Port 80 is possible, but it is better to facilitate access to this port using [port forwarding](https://en.wikipedia.org/wiki/Port_forwarding).

#### Changing password
If not setting a username and password during installation, the username will be "admin" and the password will be randomly generated. Your running YaCy node will not be as useful before changing password-protected settings. Access the password-protected parts by changing the password manually in a terminal. You can do this by going to /usr/share/yacy/bin and running:

```
./passwd.sh <new password>
```

(Note: your new password will appear in plain text in the terminal).

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
# Unlike any other crontab, you don't have to run the `crontab`
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.
```

If you want to use the root user crontab in Ubuntu instead, an example would be:

```
username@hostname:~$ sudo crontab -e 
no crontab for root - using an empty one

Select an editor. To change later, run 'select-editor'.
 1. /bin/ed
 2. /bin/nano        ← (easiest)
 3. /usr/bin/vim.basic

Choose 1-3 [2]: <enter>
```

Then add the following at the end of the file:

```
0 6 * * * /usr/bin/apt-get update && /usr/bin/apt-get -y --force-yes install yacy
```

Please note, there is no username on the line above, and absolute (full) paths are used here to prevent binary location problems!
-->
