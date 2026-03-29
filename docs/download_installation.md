<p><a class="btn btn-default btn-sm pull-right" href="https://github.com/yacy/yacy_net_homepage/blob/master/docs/download_installation.md" role="button" target="_blank">Improve this doc</a>
</p>

# Installation

YaCy installation instructions for Linux, Windows, macOS, and Docker. Choose one installation method.

<style>
.install-path-grid {
  margin: 18px 0 10px 0;
}
.install-path-row {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
  margin-bottom: 10px;
}
.install-path-card {
  display: block;
  width: 176px;
  min-height: 108px;
  margin: 0;
  padding: 12px 12px;
  border: 1px solid #d9e2d0;
  border-radius: 10px;
  background: linear-gradient(180deg, #fbfdf9 0%, #f3f9ef 100%);
  color: #2a2a2a;
  text-decoration: none !important;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  transition: box-shadow 120ms ease, transform 120ms ease, border-color 120ms ease;
  flex: 0 0 176px;
}
.install-path-card:hover,
.install-path-card:focus {
  border-color: #8bc34a;
  box-shadow: 0 6px 14px rgba(0,0,0,0.10);
  transform: translateY(-1px);
  text-decoration: none !important;
}
.install-path-card.is-primary {
  border-color: #9ed36a;
  background: linear-gradient(180deg, #f8fff2 0%, #edf8e5 100%);
}
.install-path-card .glyph {
  font-size: 18px;
  color: #4f9d2f;
  margin-right: 6px;
}
.install-path-card .title {
  display: block;
  font-weight: 700;
  font-size: 15px;
  line-height: 1.25;
  margin-bottom: 4px;
  color: #1f2c16;
}
.install-path-card .meta {
  display: block;
  font-size: 11px;
  color: #4f5b49;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  margin-bottom: 6px;
}
.install-path-card .desc {
  display: block;
  font-size: 12px;
  line-height: 1.3;
  color: #3e463a;
}
.install-path-note {
  margin: 0 0 16px 0;
  color: #5c6657;
  font-size: 12px;
}
@media (max-width: 991px) {
  .install-path-row { justify-content: center; }
  .install-path-card { width: calc(50% - 5px); min-height: 96px; flex-basis: calc(50% - 5px); }
}
@media (max-width: 600px) {
  .install-path-card { width: 100%; min-height: 0; flex-basis: 100%; }
}
</style>

<div class="install-path-grid">
  <div class="install-path-row">
    <a class="install-path-card is-primary" href="#install-from-git">
      <span class="meta"><span class="glyphicon glyphicon-wrench glyph" aria-hidden="true"></span>Recommended</span>
      <span class="title">Install from Git (latest)</span>
      <span class="desc">Clone, build with Ant, and run the latest YaCy directly from source.</span>
    </a>
    <a class="install-path-card" href="#install-docker">
      <span class="meta"><span class="glyphicon glyphicon-hdd glyph" aria-hidden="true"></span>Container</span>
      <span class="title">Docker</span>
      <span class="desc">Run YaCy as a container with persistent data volume and mapped ports.</span>
    </a>
  </div>
  <div class="install-path-row">
    <a class="install-path-card" href="#package-macos">
      <span class="meta"><span class="glyphicon glyphicon-phone glyph" aria-hidden="true"></span>Package install</span>
      <span class="title">macOS</span>
      <span class="desc">Download the `.dmg` and start YaCy as a desktop app.</span>
    </a>
    <a class="install-path-card" href="#package-linux">
      <span class="meta"><span class="glyphicon glyphicon-console glyph" aria-hidden="true"></span>Package install</span>
      <span class="title">Linux</span>
      <span class="desc">Download the `.tar.gz`, unpack it, and run `startYACY.sh`.</span>
    </a>
    <a class="install-path-card" href="#package-windows">
      <span class="meta"><span class="glyphicon glyphicon-modal-window glyph" aria-hidden="true"></span>Package install</span>
      <span class="title">Windows</span>
      <span class="desc">Use the installer (`.exe`) and launch YaCy from the installed app.</span>
    </a>
  </div>
</div>

<a id="install-from-git"></a>
## 1. Install from Git (recommended)

This installs the latest YaCy code directly from the Git repository and is currently the preferred installation path.

YaCy is often described as difficult to install, but this installation path is usually just a few commands:

- clone the repository
- build with `ant clean all dist`
- start with `./startYACY.sh`

### Requirements

- JDK 11 or newer (use the most recent JDK available; JDK 11 is the minimum)
- `ant`
- `git`

On Linux, install these with your package manager (`apt`, `dnf`, etc.). On macOS, install a recent JDK and ensure `git` and `ant` are available in your shell. On Windows, use a shell environment such as **Git Bash** (or WSL) with JDK 11+, Ant, and Git installed.

### Common build and start commands

Run the following commands:

```
git clone --depth 1 https://github.com/yacy/yacy_search_server.git
cd yacy_search_server
ant clean all dist
./startYACY.sh
```

After starting YaCy, open [http://localhost:8090](http://localhost:8090).

### Details for Different Operation Systems

#### Linux

- YaCy can run under a normal user account (no root required for running YaCy).
- If Java 11, Ant, and Git are installed, the common commands above are usually enough.

Example package install (Debian/Ubuntu):

```
sudo apt-get update
# Use the most recent JDK available in your distribution (minimum: JDK 11)
sudo apt-get install -y openjdk-17-jdk-headless ant git
```

#### macOS

- Install a recent JDK (minimum: JDK 11), `git`, and `ant`.
- If you use Homebrew, you can install the JDK with `brew install openjdk` (requires Homebrew).
- Run the common commands above in Terminal.

#### Windows

- Install a recent JDK (minimum: JDK 11), Git, and Ant.
- Open **Git Bash** (or WSL) and run the common commands above.
- If Windows asks for network access permissions for Java, allow private networks so YaCy can listen on `localhost:8090`.


## 2. Install from packaged downloads

Use this if you prefer a ready-made installer/package instead of building from Git.

<a id="package-windows"></a>
### Windows installer

* <a class="btn btn-success btn-sm" href="https://download.yacy.net/yacy_v1.941_202603291103_f0464e7fb.exe" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Windows installer (.exe)</a>

Installation:

- Double-click the downloaded installer.
- When `Windows protected your PC` appears, click `More info` -> `Run anyway`.
- When asked `Do you want to allow this app from an unknown publisher to make changes to your device`, click `Yes`.
- In the YaCy installer, click `Next`, `I Agree`, `Next`, `Install`, `Finish`.
- Start YaCy from the installed app icon.

<a id="package-linux"></a>
### Linux tarball

* <a class="btn btn-success btn-sm" href="https://download.yacy.net/yacy_v1.941_202603291103_f0464e7fb.tar.gz" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Linux package (.tar.gz)</a>

Installation:

- Install Java 11 if needed.
- Unpack the tarball.
- Start YaCy from the extracted directory.

```
tar xfz yacy<VERSION>.tar.gz
cd yacy<VERSION>
./startYACY.sh
```

<a id="package-macos"></a>
### macOS dmg

* <a class="btn btn-success btn-sm" href="https://download.yacy.net/yacy_v1.941_202603291103_f0464e7fb.dmg" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> YaCy App (.dmg)</a>

Installation:

- Double-click the downloaded `.dmg` file.
- Copy `YaCy.app` to the `Applications` folder.
- Start YaCy from `Applications`.

The macOS application stores its index in `~/Library/Application Support/net.yacy.YaCy/DATA/`, not inside the application bundle.

<a id="install-docker"></a>
## 3. Install with Docker

If you run YaCy with Docker, Java does not need to be installed on the host system.

If you do not have Docker installed, get it from [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) (macOS, Windows, Linux) or read [https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/) for Raspberry Pi and other ARM devices.

The Official YaCy Images are hosted on Dockerhub at [https://hub.docker.com/r/yacy/yacy_search_server](https://hub.docker.com/r/yacy/yacy_search_server)

We provide amd64, arm64v8 and arm32v7 versions with the following tags:

* amd64: `yacy/yacy_search_server:latest`
* arm64v8: `yacy/yacy_search_server:aarch64-latest`
* arm32v7: `yacy/yacy_search_server:armv7-latest`

To install YaCy in Intel/AMD64 environments, run:

```
docker run -d \
  --name yacy_search_server \
  -p 8090:8090 \
  -p 8443:8443 \
  -v yacy_search_server_data:/opt/yacy_search_server/DATA \
  --restart unless-stopped \
  --log-opt max-size=200m \
  --log-opt max-file=2 \
  yacy/yacy_search_server:latest
```

The default login for YaCy on Docker is `admin`:`yacy` 

To upgrade YaCy, follow the default upgrade pattern for docker images, i.e.
```
docker stop yacy_search_server
docker rm yacy_search_server
docker pull yacy/yacy_search_server:latest
```
.. and restart the container with the same command that you used initially to run the container, i.e. (like above)
```
docker run -d \
  --name yacy_search_server \
  -p 8090:8090 \
  -p 8443:8443 \
  -v yacy_search_server_data:/opt/yacy_search_server/DATA \
  --restart unless-stopped \
  --log-opt max-size=200m \
  --log-opt max-file=2 \
  yacy/yacy_search_server:latest
```
This will mount the data volume from the upgraded yacy instance.

#### Configuration with Environment Variables
All of the environment variables (see https://github.com/yacy/yacy_search_server/blob/master/defaults/yacy.init ) can be overwritten with the `docker run` command. The environment variables are named like those in the `yacy.init` files, with all `.` (dot) replaced with `_` (underscore), all uppercase and prefixed with `YACY_`. 

For example: the default peer name can be set with `network.unit.agent` in `yacy.init`. To pre-set this value during `docker run` time, set the environment variable `YACY_NETWORK_UNIT_AGENT`. The corresponding run command would be:
```
docker run -d \
  --name yacy_search_server \
  -p 8090:8090 \
  -p 8443:8443 \
  -e YACY_NETWORK_UNIT_AGENT=Choomba \
  -v yacy_search_server_data:/opt/yacy_search_server/DATA \
  --restart unless-stopped \
  --log-opt max-size=200m \
  --log-opt max-file=2 \
  yacy/yacy_search_server:latest
```
This can also be used to re-start a previously started image to overwrite the already stored configuration values.

#### Backup and restore of DATA folder
All data from YaCy is written into the data folder which is stored in the docker volume `yacy_search_server_data`. To back-up that DATA folder to `/tmp/DATA.tar.gz`, just run
```
docker stop yacy_search_server
docker run --rm -v yacy_search_server_data:/opt/yacy_search_server/DATA -v /tmp:/tmp openjdk:11-jre-slim bash -c "cd /opt/yacy_search_server && tar -cf - DATA | xz -q -3v -T0 > /tmp/DATA.tar.xz"
docker start yacy_search_server
```

To restore the DATA folder from `/tmp/DATA.tar.gz`, run
```
docker stop yacy_search_server
docker run --rm -v yacy_search_server_data:/opt/yacy_search_server/DATA -v /tmp:/tmp openjdk:11-jre-slim bash -c "cd /opt/yacy_search_server && rm -rf DATA/* && tar xf /tmp/DATA.tar.xz"
docker start yacy_search_server
```
This will restore the data volume contents for the YaCy instance.

For all installation variants: open [http://localhost:8090](http://localhost:8090) in your web browser after starting YaCy.

## Post-Installation

When all works,

* YaCy is now running on port 8090 on your machine. Open [http://localhost:8090](http://localhost:8090) in your web-browser.
* No password is required when accessing this YaCy instance from localhost. Howwever if you access your peer from another host, the default password for the account `admin` is `yacy`.

You should always set a new admin password!

* You can set the administration password in the front-end at `/ConfigAccounts_p.html`, or
* Headless operation can be achieved by setting a password on the host console with `bin/passwd.sh <password>`

 If you have problems, get help with the YaCy community:
 
* [https://community.searchlab.eu](https://community.searchlab.eu)
* see also the [YaCy Screenshots](https://yacy.net/demonstration_tutorial_screenshot/)


# Kubernetes 

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

# Please Support YaCy

YaCy is libre software - licensed GPL-2+. Downloads are provided for free! Please consider becoming a permanent supporter of YaCy to ensure that YaCy can actively be developed! 

## Become a YaCy Patron

<a href="https://www.patreon.com/bePatron?u=185903"><img src="../../img/sponsor_patreon.png" alt="Become a Patron" height="128" align="left" style="padding-left:8%;padding-right:20px"></a>
<a href="https://github.com/users/Orbiter/sponsorship"><img src="../../img/sponsor_github.png" alt="Become a GitHub Sponsor" height="128" align="left" style="padding-left:8%"></a>
<br><br><br><br><br>

## One-Time Donation

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
