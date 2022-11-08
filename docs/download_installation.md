# Download and Installation of YaCy


YaCy is available as packages for Linux, Windows, macOS and also as a Docker Image. You can also install YaCy on any other operation system either by compiling it yourself or using a tarball. YaCy needs Java 8, OpenJDK 8 is recommended.

<p><a class="btn btn-default btn-sm pull-right" href="https://github.com/yacy/yacy_net_homepage/blob/master/docs/download_installation.md" role="button" target="_blank">Improve this doc</a>
</p>

## Please Support YaCy


YaCy is libre software - licensed GPL-2+. Downloads are provided for free! Please consider becoming a permanent supporter of YaCy to ensure that YaCy can actively be developed! 

### Become a YaCy Patron

<a href="https://www.patreon.com/bePatron?u=185903"><img src="../../img/sponsor_patreon.png" alt="Become a Patron" height="128" align="left" style="padding-left:8%;padding-right:20px"></a>
<a href="https://github.com/users/Orbiter/sponsorship"><img src="../../img/sponsor_github.png" alt="Become a GitHub Sponsor" height="128" align="left" style="padding-left:8%"></a>
<br><br><br><br><br>

### One-Time Donation

<form target="_blank" action="https://www.paypal.com/cgi-bin/webscr" method="post" style="margin:0px; padding:0px;">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="on0" value="Your contribution is happily received as a tax-deductable, legal payment.">
<img src="https://yacy.net/img/pp-logo-100px.png" alt="PayPal">&nbsp;
<input type="radio" name="os0" value="beneficial" checked>&nbsp;<label>5 &euro;</label>&nbsp;
<input type="radio" name="os0" value="generous">&nbsp;<label>25 &euro;</label>&nbsp;
<input type="radio" name="os0" value="gracious">&nbsp;<label>50 &euro;</label>&nbsp;
<input type="hidden" name="currency_code" value="EUR">
<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
<input class="btn btn-success btn-sm" type="submit" name="submit" value="Donate">
</form><br/>

## Installation

Installation is very easy on any system. If it looks complex here it's just because we give directions in great detail.

### Compile YaCy yourself
You can download and build your own YaCy with these simple steps. This is probably the best and easiest ways for everyone who knows how to use a command line interface. You need:

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
* <a class="btn btn-success btn" href="https://download.yacy.net/yacy_v1.924_20210209_10069.tar.gz" role="button">Download generic YaCy</a> from [https://download.yacy.net/yacy_v1.924_20210209_10069.tar.gz](https://download.yacy.net/yacy_v1.924_20210209_10069.tar.gz), i.e. by
```
wget https://download.yacy.net/yacy_v1.924_20210209_10069.tar.gz
```

* Unpack the tarball.
```
tar xfz yacy_v1.924_20210209_10069.tar.gz
```

* Run `startYACY.sh` inside your decompressed folder.
```
cd yacy
./startYACY.sh
```

Installing from start to finish would look something like this, depending on your distro.
```
sudo apt-get update
sudo dpkg --configure -a
sudo apt-get install -y openjdk-8-jre-headless
wget https://download.yacy.net/yacy_v1.924_20210209_10069.tar.gz
tar xfz yacy_v1.924_20210209_10069.tar.gz
cd yacy
./startYACY.sh
```

* YaCy is now running on port 8090 on your machine. Open [http://localhost:8090](http://localhost:8090) in your web-browser.
* No password is required when accessing this YaCy instance from localhost.
* Headless operation can be achieved by setting a password on the host console with `bin/passwd.sh <password>`.


### On macOS

* Install Java 8 from [https://adoptopenjdk.net/](https://adoptopenjdk.net/).
* <a class="btn btn-success btn" href="https://download.yacy.net/yacy_v1.924_20201214_10042.dmg" role="button">Download YaCy for macOS</a> from [https://download.yacy.net/yacy_v1.924_20201214_10042.dmg](https://download.yacy.net/yacy_v1.924_20201214_10042.dmg)
* Double-click the downloaded `.dmg`-file and copy the YaCy app out of the mounted drive into your "Application" folder.
* To run YaCy, just double-click the YaCy app icon in your "Application" folder.
* YaCy is now running on port 8090 on your machine. Open [http://localhost:8090](http://localhost:8090) in your web-browser.


### Docker ###

Running YaCy in docker is easy. If you don't hava docker installed, get it from [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) (for macOS, Windows and Linux) or read the instructions from [https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/) to install docker on Raspberry Pi or any other ARM-based devices.

The Official YaCy Images are hosted on Dockerhub at [https://hub.docker.com/r/yacy/yacy_search_server](https://hub.docker.com/r/yacy/yacy_search_server)

We provide amd64, arm64v8 and arm32v7 versions with the following tags:

* amd64: `yacy/yacy_search_server:latest`
* arm64v8: `yacy/yacy_search_server:aarch64-latest` 
* arm32v7: `yacy/yacy_search_server:armv7-latest`

i.e. to install YaCy in intel-based environmnts, run:
```
docker run -d --name yacy_search_server -p 8090:8090 -p 8443:8443 -v yacy_search_server_data:/opt/yacy_search_server/DATA --restart unless-stopped --log-opt max-size=200m --log-opt max-file=2 yacy/yacy_search_server:latest
```
then open http://localhost:8090 in your web-browser.

The default login for YaCy on Docker is `admin`:`yacy` 

To upgrade YaCy, follow the default upgrade pattern for docker images, i.e.
```
docker stop yacy_search_server
docker rm yacy_search_server
docker pull yacy/yacy_search_server:latest
```
.. and restart the container with the same command that you used initially to run the container, i.e. (like above)
```
docker run -d --name yacy_search_server -p 8090:8090 -p 8443:8443 -v yacy_search_server_data:/opt/yacy_search_server/DATA --restart unless-stopped --log-opt max-size=200m --log-opt max-file=2 yacy/yacy_search_server:latest
```
This will mount the data volume from the upgraded yacy instance.

#### Configuration with Environment Variables ####
All of the environment variables (see https://github.com/yacy/yacy_search_server/blob/master/defaults/yacy.init ) can be overwritten with the `docker run` command. The environment variables are named like those in the `yacy.init` files, with all `.` (dot) replaced with `_` (underscore), all uppercase and prefixed with `YACY_`. 

For example: the default peer name can be set with `network.unit.agent` in `yacy.init`. To pre-set this value during `docker run` time, set the environmnt variable `YACY_NETWORK_UNIT_AGENT`. The correspondig run command would be:
```
docker run -d --name yacy_search_server -p 8090:8090 -p 8443:8443 -e YACY_NETWORK_UNIT_AGENT=Choomba -v yacy_search_server_data:/opt/yacy_search_server/DATA --restart unless-stopped --log-opt max-size=200m --log-opt max-file=2 yacy/yacy_search_server:latest
```
This can also be used to re-start a previously started image to overwrite the already stored configuration values.

#### Backup and restore of DATA folder ####
All data from YaCy is written into the data folder which is stored in the docker volume `yacy_search_server_data`. To back-up that DATA folder to `/tmp/DATA.tar.gz`, just run
```
docker stop yacy_search_server
docker run --rm -v yacy_search_server_data:/opt/yacy_search_server/DATA -v /tmp:/tmp openjdk:8-stretch bash -c "cd /opt/yacy_search_server && tar -cf - DATA | xz -q -3v -T0 > /tmp/DATA.tar.xz"
docker start yacy_search_server
```

To restore the DATA folder from `/tmp/DATA.tar.gz`, run
```
docker stop yacy_search_server
docker run --rm -v yacy_search_server_data:/opt/yacy_search_server/DATA -v /tmp:/tmp openjdk:8-stretch bash -c "cd /opt/yacy_search_server && rm -rf DATA/* && tar xf /tmp/DATA.tar.xz"
docker start yacy_search_server
```

### Kubernetes ###

```
# optional: for a quick and easy installation of Kubernetes, run minikube
minikube start
minikube dashboard

# optional: if you want to run YaCy in a new namespace (does not work with minikube dashboard)
kubectl create namespace searchlab
kubectl config set-context --current --namespace=searchlab

# create deployment
kubectl create deployment yacy --image=yacy/yacy_search_server:latest --replicas=1 --port=8090
kubectl get deployment yacy -o wide # optional: show attributes of deployment
kubectl logs -f deployment.apps/yacy # optional: show logs of deployment

# create service
kubectl create service nodeport yacy --node-port=30890 --tcp=8090:8090
kubectl get service yacy -o wide # optional: show service configuration

# optional: access service in minicube
minikube service list
minikube service yacy
minikube service yacy -n searchlab # in case you are running in namespace 'searchlab'

# optional: shut down the YaCy deployment
kubectl delete service yacy
kubectl delete deployment yacy

# optional: switch back to default namespace
config set-context --current --namespace=default
```

### Any OS with Java 8
Automatic development builds can be obtained from
[https://download.yacy.net/](https://download.yacy.net/).


### Get the Source Code
The source code is inside the generic tarball. It is recommended you clone the Git repository at
[https://github.com/yacy/yacy_search_server](https://github.com/yacy/yacy_search_server).
