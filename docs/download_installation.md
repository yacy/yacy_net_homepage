# Download and Install YaCy

Choose one installation method. After YaCy starts, open [http://localhost:8090](http://localhost:8090) in your browser.

<style>
.install-mobile-note {
  display: none;
  margin: 16px 0 20px 0;
  padding: 12px 14px;
  background-color: #4E5D6C;
  border-left: 4px solid #30c0ff;
}
.install-mobile-note p {
  margin: 0;
}
.install-methods {
  margin: 18px 0 28px 0;
  padding-left: 0;
  list-style: none;
}
.install-methods li {
  margin: 0 0 12px 0;
  padding: 0 0 12px 0;
  border-bottom: 1px solid rgba(255,255,255,0.14);
}
.install-methods strong {
  display: block;
  color: #ffffff;
}
.install-methods span {
  display: block;
  color: #B1B7B9;
}
.download-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin: 14px 0 22px 0;
}
.download-actions .btn {
  white-space: normal;
}
div[role="main"] a,
div[role="main"] :not(pre) > code {
  overflow-wrap: anywhere;
  word-break: break-word;
}
div[role="main"] :not(pre) > code {
  white-space: normal;
}
div[role="main"] pre {
  max-width: 100%;
  overflow-x: auto;
}
@media (max-width: 991px) {
  .install-mobile-note { display: block; }
}
</style>

<div class="install-mobile-note">
  <p>YaCy runs on desktop and server systems, not on phones. If you are reading this on mobile, use this page to choose an installation method and continue on the computer or server where YaCy should run.</p>
</div>

## Choose an Installation Method

<ul class="install-methods">
  <li><strong><a href="#packaged-downloads">Packaged downloads</a></strong><span>Use these for a desktop-style install on Windows, macOS, or Linux.</span></li>
  <li><strong><a href="#install-from-git">Install from Git</a></strong><span>Recommended if you want the latest YaCy code and are comfortable with command-line tools.</span></li>
  <li><strong><a href="#install-docker">Docker</a></strong><span>Use this for servers, containers, and deployments with a persistent data volume.</span></li>
</ul>

<a id="packaged-downloads"></a>
## Packaged Downloads

<div class="download-actions">
  <a class="btn btn-success" href="https://download.yacy.net/yacy_v1.941_202603291103_f0464e7fb.exe" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Windows installer (.exe)</a>
  <a class="btn btn-success" href="https://download.yacy.net/yacy_v1.941_202603291103_f0464e7fb.dmg" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> macOS app (.dmg)</a>
  <a class="btn btn-success" href="https://download.yacy.net/yacy_v1.941_202603291103_f0464e7fb.tar.gz" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Linux package (.tar.gz)</a>
</div>

Use a packaged download if you prefer an installer or archive instead of building from Git.

### Windows Installer

- Double-click the downloaded installer.
- When `Windows protected your PC` appears, click `More info` -> `Run anyway`.
- When asked `Do you want to allow this app from an unknown publisher to make changes to your device`, click `Yes`.
- In the YaCy installer, click `Next`, `I Agree`, `Next`, `Install`, `Finish`.
- Start YaCy from the installed app icon.

### macOS App

- Double-click the downloaded `.dmg` file.
- Copy `YaCy.app` to the `Applications` folder.
- Start YaCy from `Applications`.

The macOS application stores its index in `~/Library/Application Support/net.yacy.YaCy/DATA/`, not inside the application bundle.

### Linux Package

- Install Java if needed.
- Unpack the tarball.
- Start YaCy from the extracted directory.

```
tar xfz yacy<VERSION>.tar.gz
cd yacy<VERSION>
./startYACY.sh
```

<a id="install-from-git"></a>
## Install from Git

This installs the latest YaCy code directly from the Git repository and is currently the preferred installation path.

This installation path is usually just a few commands:

- clone the repository
- build with `ant clean all dist`
- start with `./startYACY.sh`

### Requirements

- JDK 17 or newer (use the most recent JDK available; JDK 17 is the minimum)
- `ant`
- `git`

On Linux, install these with your package manager (`apt`, `dnf`, etc.). On macOS, install a recent JDK and ensure `git` and `ant` are available in your shell. On Windows, use a shell environment such as **Git Bash** (or WSL) with JDK 17+, Ant, and Git installed.

### Common build and start commands

Run the following commands:

```
git clone --depth 1 https://github.com/yacy/yacy_search_server.git
cd yacy_search_server
ant clean all dist
./startYACY.sh
```

After starting YaCy, open [http://localhost:8090](http://localhost:8090).

### Platform Notes

#### Linux

- YaCy can run under a normal user account (no root required for running YaCy).
- If Java 17, Ant, and Git are installed, the common commands above are usually enough.

Example package install (Debian/Ubuntu):

```
sudo apt-get update
# Use the most recent JDK available in your distribution (minimum: JDK 17)
sudo apt-get install -y openjdk-17-jdk-headless ant git
```

#### macOS

- Install a recent JDK (minimum: JDK 17), `git`, and `ant`.
- If you use Homebrew, you can install the JDK with `brew install openjdk` (requires Homebrew).
- Run the common commands above in Terminal.

#### Windows

- Install a recent JDK (minimum: JDK 17), Git, and Ant.
- Open **Git Bash** (or WSL) and run the common commands above.
- If Windows asks for network access permissions for Java, allow private networks so YaCy can listen on `localhost:8090`.


<a id="install-docker"></a>
## Install with Docker

If you run YaCy with Docker, Java does not need to be installed on the host system.

If you do not have Docker installed, get it from [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) (macOS, Windows, Linux) or read [https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/) for Raspberry Pi and other ARM devices.

The official YaCy images are hosted on Docker Hub at [https://hub.docker.com/r/yacy/yacy_search_server](https://hub.docker.com/r/yacy/yacy_search_server)

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

To upgrade YaCy, follow the default upgrade pattern for Docker images:
```
docker stop yacy_search_server
docker rm yacy_search_server
docker pull yacy/yacy_search_server:latest
```
Then restart the container with the same command that you used initially:
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
This reuses the existing data volume with the upgraded YaCy instance.

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
This can also be used when restarting a previously created container to overwrite stored configuration values.

#### Backup and restore the DATA folder
YaCy stores its data in the Docker volume `yacy_search_server_data`. To back up that DATA folder to `/tmp/DATA.tar.xz`, run:
```
docker stop yacy_search_server
docker run --rm -v yacy_search_server_data:/opt/yacy_search_server/DATA -v /tmp:/tmp openjdk:17-jre-slim bash -c "cd /opt/yacy_search_server && tar -cf - DATA | xz -q -3v -T0 > /tmp/DATA.tar.xz"
docker start yacy_search_server
```

To restore the DATA folder from `/tmp/DATA.tar.xz`, run:
```
docker stop yacy_search_server
docker run --rm -v yacy_search_server_data:/opt/yacy_search_server/DATA -v /tmp:/tmp openjdk:17-jre-slim bash -c "cd /opt/yacy_search_server && rm -rf DATA/* && tar xf /tmp/DATA.tar.xz"
docker start yacy_search_server
```
This restores the data volume contents for the YaCy instance.

For all installation variants: open [http://localhost:8090](http://localhost:8090) in your web browser after starting YaCy.

## Post-Installation

After YaCy starts:

* Open [http://localhost:8090](http://localhost:8090) in your web browser.
* Local access does not require a password. If you access YaCy from another host, the default account is `admin` with password `yacy`.
* Set a new admin password before exposing YaCy on a network.
* Set the administration password in the web interface at `/ConfigAccounts_p.html`, or use `bin/passwd.sh <password>` for headless operation.

If you have problems, get help from the YaCy community:
 
* [https://community.searchlab.eu](https://community.searchlab.eu)
* see also the [YaCy Screenshots](https://yacy.net/demonstration_tutorial_screenshot/)

## Support YaCy

YaCy is free software. If YaCy is useful to you, please consider supporting ongoing development.

<p>
  <a class="btn btn-default" href="https://patreon.com/orbiterlab" role="button">Support on Patreon</a>
  <a class="btn btn-default" href="https://github.com/sponsors/Orbiter" role="button">Sponsor on GitHub</a>
</p>
