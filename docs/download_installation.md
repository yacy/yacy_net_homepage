# Download and Installation of YaCy

YaCy is available as packages for Windows, Macintosh and Debian packages. You can also install YaCy on any other operation system using a tarball. YaCy needs Java 8, we recommend to run Openjdk 8.

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

### Windows Installer
[http://latest.yacy.net/yacy_v1.922_20191014_9966.exe](http://latest.yacy.net/yacy_v1.922_20191014_9966.exe)

### Mac Application
[http://latest.yacy.net/yacy_v1.922_20191013_9964.dmg](http://latest.yacy.net/yacy_v1.922_20191013_9964.dmg)

### Generic Tarball
[http://latest.yacy.net/yacy_v1.922_20191013_9964.tar.gz](http://latest.yacy.net/yacy_v1.922_20191013_9964.tar.gz)

### Debian Package
Our packages are released at [http://debian.yacy.net/](http://debian.yacy.net/).
Please see the instructions below for the installation process.

### Get the Source Code
The source code is inside the generic tarball. We recommend that you clone our git repository at
[https://github.com/yacy/yacy_search_server](https://github.com/yacy/yacy_search_server)

### Development builds
Automatic builds can be obtained from
[http://latest.yacy.net/](http://latest.yacy.net/)

## Installation
If you know how to install Java on your computer and how to start a shell script, the process is very simple:

* Install JDK 8 (Oracle or OpenJDK)
* Download and decompress the tarball
* Run `startYACY.sh` inside your decompressed folder
* YaCy is then running on port 8090; i.e. open [http://localhost:8090](http://localhost:8090) in your browser
* no password is required when accessing this YaCy instance from localhost
* for headless operation, set the password on the host console with `bin/passwd.sh <password>`
