# YaCy and Tor



**Note:** YaCy is not yet able to recognise Tor URLs, therefore you should
use YaCy as "tor-only", otherwise useless URLs will be sent to normal peers. 
Please follow all steps and read all hints carefully.


Peers in the public cluster should blacklist Tor-URLs to prevent seeding
.onion URLs sent to them by wrongly configured peers.  The blacklist entry
should look like this: `*.onion/.*`

**Note:** This How-To is divided in two parts. Please complete part 1 fist before starting with the part 2. 






**Warning!** There is no whitelisting filter anymore, so you are not able to run tor-only yacy 



Thread about Whitelisting feature:

  - <http://forum.yacy-websuche.de/viewtopic.php?f=5&t=999&hilit=#p7478>

  


## Goal

An independent YaCy network to index Tor hidden services is to be build.
No normal Internet sites should be indexed for that purpose. There also
is a [another YaCy network](#similar-yacy-networks) to
index both Tor hidden-services and normal Web sites.

## Help

Should you have questions or need help, go to the [English YaCy
forum](http://www.huzzaar.com/yacy-forum/)

## Part 1 - Configuring Tor and Privoxy

Please install Tor and Privoxy first. The installation depends on your
operating system. Read the OS specific manual.

### Configuring Tor

Its sufficient to run Tor as a client, though we are going to install a
hidden service later on. The Tor package comes fully configured to run
out of box as a client. Nevertheless you should edit your Tor
configuration file (e.g. `/etc/tor/torrc`) to increase system-security.

First of all look for "SocksPort", which defaults to 9050:

    SocksPort 9050

Remember this port number.

If you connect to Tor from the same system only, prevent other IPs from
connecting by binding Tor to localhost:

    SocksListenAddress 127.0.0.1:9050

Additionally you should restrict access on the Socksport:

    SocksPolicy accept 127.0.0.0/8
    SocksPolicy reject *

`ORPort`, `ORListenAddress`, `DirPort` or `DirListenAddress` only need
to be set if you run Tor as a server.

`ControlPort` only needs to be set if you run a control application.

Make sure to disable logging, otherwise sensitive informations will be
logged. Using

    Log notice syslog

only writes minimal information to syslog. (Apparently `Log notice` has
to be set, otherwise Tor won't start properly. The configuration may
vary for different operating systems.)

Who wants to feel really safe can optionally set

    ExitPolicy reject *:*

and

``` 
 BandwidthRate 50 KB
```

This will limit damage in case of misconfiguration by reducing traffic
and restricting connections

-----

Here is the configuration as a whole (depends on your OS, this is for
Linux)

    ExitPolicy reject *:*
    User tor 
    Group tor 
    PIDFile /var/run/tor.pid
    SocksPort 9050
    SocksListenAddress 127.0.0.1:9050
    SocksPolicy accept 127.0.0.0/8
    SocksPolicy reject *
    Log notice syslog
    DataDirectory   /var/lib/tor/data
    # ControlPort 9051
    # RunAsDaemon 1 # has to be set depending on os
    BandwidthRate 50 KB

### Configuring Privoxy

The following how-to assumes you will use Privoxy for Tor only.

Edit privoxy's configuration file (e.g. `/etc/privoxy/config`). Check or
edit the following settings.

Don't log every requested page. You only need startup and error
messages. Probably the best is to not log anything at all:

    debug 0

Make sure only localhost is allowed to connect and privoxy listens to
port 8118.

    listen-address 127.0.0.1:8118

Privoxy filter should be switched off, since it just acts as proxy
between YaCy and tor. You also can switch off toggling:

    toggle 0
    enable-remote-toggle 0
    enable-remote-http-toggle 0

You may disable editing filtes and rules, too.

    enable-edit-actions 0

The most important is to forward all connections to the Tor (9050).
(Don't forget the dot at the end of line)

    forward-socks4a / 127.0.0.1:9050 .

`forwarded-connect-retries` should be slightly increased to improve
connections. I recommend 2 or 3:

    forwarded-connect-retries 2

-----

This is a listing of all settings (depends on OS, here Linux):

    confdir /etc/privoxy
    logdir /var/log/privoxy
    actionsfile standard
    actionsfile default
    actionsfile user
    filterfile default.filter
    logfile privoxy.log
    debug 0
    # debug 1 # make sure to uncomment!
    listen-address 127.0.0.1:8118
    toggle  0
    enable-remote-toggle 0
    enable-remote-http-toggle 0
    enable-edit-actions 0
    buffer-limit 4096
    forward-socks4a / 127.0.0.1:9050 .
    forwarded-connect-retries 2

### Check configuration

Before you start to configure YaCy, you should test the configuration of
Tor and privoxy to make sure everything works fine. Wait some time to
let Tor connect to the the Tor network. Start your browser and configure
it to use a proxy with proxyhost `localhost` and proxyport `8118`. Visit
an tor-URL, e.g.:

  - [Hidden Wiki](http://6sxoyfb3h2nvok2d.onion/)
  - [Invisi Wiki](http://2qrww3nv5w3ue3ir.onion/)
  - [APE Wiki](http://anegvjpd77xuxo45.onion/)

When you are able to connect to an onion URL successfully, continue with
part 2 of the how-to. If you are having trouble, check your
configuration files and reread the documentation of Tor and privoxy
carefully.

Don't forget to remove the proxy settings from your
browser-configuration.

## Part 2 - Configuring a hidden-service and YaCy

**Note:** You just should continue with this part if Tor and Privoxy are running correctly 



### Configuring a hidden-service

Shutdown Tor. Modify the Tor configuration file and add an entry to
support YaCy as a hidden-service e.g.:

    HiddenServiceDir /var/lib/tor/yacy/
    HiddenServicePort 8181 127.0.0.1:8181

Port 8181 is the YaCy port we will use later.

After restarting Tor you will find a file named `hostname` in the
directory `HiddenServiceDir`. The hostname in this file (e.g.
*1a2b3c4d5e6f7g89.onion*) will be needed later.

### Configuring YaCy

#### Preamble

First of all, there are several ways to modify YaCy's configuration. One
is to edit the file yacy.init, another is to edit httpProxy.conf
directly. It's up to you which way you choose.

It's recommended to download an up to date version of YaCy and to modify
the yaci.init **before** starting it the first time. This way it is
ensured that YaCy didn't make contacts and didn't build an index yet.
The informations in yacy.init will be written to
DATA/SETTINGS/httpProxy.conf on the first startup.

There are also several ways to modify superseed.txt and here too I will
describe an unusual way to prevent that superseed.txt will be
overwritten when updating.

The recommended edits are optimal for my configuration. If you use
another configuration, make sure you know what you are doing.

Under no circumstances you should try to modify an already used
(started) YaCy installation since there are several traps that are not
documented and which will cause YaCy to contact public YaCy clusters and
distribute onion URLs.

Ok, let's start. First change into the YaCy directory. All following
pathnames are relative to the YaCy directory.

#### Modifying the configuration files

Now we will modify yacy.init. Only the setting we have to modify are
listed.

First we have to set the port on which YaCy will be reachable and which
is different from the normal YaCy port.

    port = 8181

Then we need to set another location of the net definition files since
the standard ones will be overwritten with every update.

    network.unit.definition = ../yacy.network.unit.tor
    network.group.definition = ../yacy.network.group.tor

Automatic update should work, but it hasn't been tested sufficiently yet
and until we can be sure it won't destroy anything we better disable it:

    update.process = manual

It's also important to replace the blacklist with a whitelist so that
only the domains will be indexed which are in the list, instead of
indexing all domains which are *not* in the list. This way we make sure
that only hidden services will be indexed, since they are defined by the
onion domain. Later we will configure the whilelist.

    BlackLists.class=de.lulabad.blacklist.advancedWhiteURLPattern

Now we make sure YaCy only will contact the Internet through privoxy:

    remoteProxyUse=true
    remoteProxyHost=localhost
    remoteProxyPort=8118

Since the DNS-resolution only delivers local network addresses, we have
to empty the IP address blocklist for the proxy, otherwise YaCy would
try to connect to sites directly without using the proxy and thus won't
be able to find them:

    remoteProxyNoProxy=

The following settings make the seedfile available in the Tor network:

    seedUploadMethod=File
    seedFilePath=htroot/seed.txt
    seedURL=http://1a2b3c4d5e6f7g89.onion:8181/seed.txt

Now we give our YaCy a freely selectable name:

    peerName=TorYaCy

YaCy needs to run in debug mode to handle local addresses (as used by
Tor) correctly:

    yacyDebugMode=true

To be able to make a connection, YaCy needs to be told from which
hostname (domain) it is reachable:

    staticIP=1a2b3c4d5e6f7g89.onion

Should you want YaCy to open a browser window, just skip the following
option. Otherwise set:

    browserPopUpTrigger=false

Since the Tor network is not the fastest, we set all timeouts to high
values:

    clientTimeout=90000
    crawler.clientTimeout=90000
    proxy.clientTimeout=90000
    indexControl.timeout = 180000
    indexDistribution.timeout = 180000
    indexTransfer.timeout = 360000

The following options are very important for that our peer won't contact
any public clusters but only other Tor-YaCy peers:

    CRDistOn = false
    CRDist1Target  =

For security reasons it is also important that the proxy isn't reachable
from the Tor network. The following configuration describes the scenario
that YaCy is running on the same computer as Tor. Then you need to set
for example 192.168.1.2 as the address for the server in your browser
instead of localhost:

    proxyClient=192.168.*,10.*

At last we set several options to increase the anonymity in the Tor
network:

    proxy.sendViaHeader=false
    proxy.sendXForwardedForHeader=false
    useYacyReferer=false
    useYacyReferer__pro = false

Optionally we can set the following options to restrict the maximum file
size (here \~10MB) and to reduce the cache size on a minumum (here 4MB),
because the sites we browse are cached there:

    crawler.ftp.maxFileSize=10000000
    crawler.http.maxFileSize=10000000
    proxyCacheSize=4



**Note:** If you run YaCy using Linux or any similar OS: Don't forget to set
the right owner/group and the right file modes to files and YaCy
directories, especially `DATA/SETTINGS` and the file `httpProxy.conf`
located in there, e.g.  `chown -R yacy: ./` |



#### Activate Whitelist


**Warning:** There is no whitelisting filter anymore, so you are not able to run tor-only yacy |



Thread about Whitelisting feature:

  - <http://forum.yacy-websuche.de/viewtopic.php?f=5&t=999&hilit=#p7478>

~~YaCy only supports a blacklist by default, therefore you have to
download
[\[1\]](http://yacy-websuche.de/wiki/index.php/Benutzer:Lulabad#regex_Whitelist_.28erst_ab_0.3.29%7CadvancedBlacklist-0.3.jar)
(or higher) and copy it to libx. After that the previously configured
filter is available.~~

Sorry, but this Whitelist can't be used at this moment:

  - <http://forum.yacy-websuche.de/viewtopic.php?f=5&t=999&hilit=#p7478>

Now we just have to make an entry to only index *.onion* sites:

  - Create the subfolder DATA
  - Create the sub-subfolder LISTS (DATA/LISTS)
  - Create the file url.default.black (DATA/LISTS/url.default.black)
    with the following content:

<!-- end list -->

    *.onion/.*

A possible workaround is to use a filtered proxy in front of YaCy they
accept only \*.onion domains.

#### Defining the YaCy-Tor-network

By now, YaCy is able to build and define separated networks:
[Netzdefinition](./de:netzdefinition.html "De:Netzdefinition")

The current definitions can be downloaded from
[\[2\]](http://byi4akelnxrz5tab.onion:8081/yacy.network.unit.tor) and
[\[3\]](http://byi4akelnxrz5tab.onion:8081/yacy.network.group.tor).

`yacy.network.group.tor` is empty and `yacy.network.unit.tor` has the
following content:

    network.unit.name = torworld
    network.unit.description = Yacy network for TOR https://www.torproject.org/
    network.unit.domain = any
    network.unit.search.time = 4
    network.unit.dhtredundancy.junior = 1
    network.unit.dhtredundancy.senior = 3
    network.unit.bootstrap.seedlist0 = http://byi4akelnxrz5tab.onion:8081/seed.txt
    network.unit.bootstrap.seedlist1 = http://pah22f4rpnz4hoyn.onion:8084/seed.txt
    network.unit.bootstrap.seedlist2 = http://zxbagwypsfbicebv.onion:8091/seed.txt
    network.unit.update.location0 = http://yacy.net/Download.html
    network.unit.update.location1 = http://latest.yacy.de
    network.unit.update.location2 = http://www.findenstattsuchen.info/YaCy/latest/index.php
    network.unit.protocol.control = uncontrolled

#### Starting YaCy

Now you may start YaCy. Watch the log file and maybe the network graph,
since other Tor-YaCy should be seen within minutes. Public IPs shouldn't
rise in the log file. Error messages caused by the seedfiles may appear
in the beginning and can be ignored as soon as the first other Tor-YaCy
are found.



**Warning:**
Visit <http://localhost:8181> and set an admin password when you start yacy for the first time. 



#### Using YaCy

Enter proxyhost `localhost` and proxyport `8181` into your
browserconfiguration. Now you should be able to visit Tor hidden
services using YaCy.

# Notes

Tor is a slow and sometimes unstable system and sometimes it can take a
while until the YaCy peers find eachother and exchange data. Be patient.

  - Some Tor pages have to be reloaded several times
  - DHT transfer to other tor-YaCy is working (untested)
  - RankingDistribution to other tor-YaCy is working (untested)
  - The status of a peer depends on the quality of the connection. Don't
    be suprised if you are principal and some minutes later you are
    junior.
  - Don't index the Internet sites using Tor-YaCy. That would destroy
    the Tor-only index. You may find filter rules which block the access
    to the Internet at other tor-peers. Use them\!
  - The German version of this article can be found at the
    tor-hiddenwiki. Who modifies the article, should modify it there,
    too: <http://6sxoyfb3h2nvok2d.onion/tor/TorYaCyHowto>

# Security Hints

  - logging should be disabled in all programs or the log-files should
    be placed on a ramdisk, it is the same for YaCy.
  - YaCy's HTCACHE should be placed on a ramdisk
  - when starting crawls, these should be run local and not distributed,
    don't forget to set the filter rule to onion-domains
  - wiki and blog should be used carefully
  - public bookmarks shouldn't be used
  - browser cache and browser history should be deactivated
  - paranoid people can install YaCy on an encrypted filesystem

# Seeds for Tor-YaCy

Please only post well available seed files. These seed files can be
added to the unit file.

  - <http://byi4akelnxrz5tab.onion:8081/seed.txt>
  - <http://pah22f4rpnz4hoyn.onion:8084/seed.txt>
  - <http://zxbagwypsfbicebv.onion:8091/seed.txt>

If your Tor-yacy is up and running, please post the URL to your seedfile
here (the one from `seedURL`)

# Demo-peers

Beware, maybe they are down.

  - <http://byi4akelnxrz5tab.onion:8081/>
  - <http://zxbagwypsfbicebv.onion:8091/>

<!-- end list -->

  - <http://pah22f4rpnz4hoyn.onion:8084/>
  - <http://2vkpt4pelhbu7yfw.onion:8181/>
  - <http://k3ttdasxnbvtbfwm.onion:8181/>
  - <http://iwhfgshjfhygilti.onion:8181/>

# Similar YaCy networks

Please always join already existing networks whenever possible. Tor's
resources are limited and should be spared. In addition it is hard
enough to connect enough servers to build a stable Tor-YaCy-network.

## *freeworld*

That is not a dedicated network, but *usal* YaCy server, there are
provided as hidden service in tor network, too.

So they are **not** crawl tor hidden services, but enable tor users to
use directly and anonymous yacy server.

Servers:

  - <http://xwfgwneu5lbeawgl.onion:8080>

Please announce your server in tor network, too:

  - [Announce new hidden services](http://eqt5g4fuenphqinx.onion/sites)
  - [Discussion about YaCy and Tor and announcing some YaCy
    servers](http://eqt5g4fuenphqinx.onion/talk/272)

## anonymworld


**Warning:** This network is shutted down. It's mor important to support the common *freeworld* and the special *torworld* network. It would be more usefull to provide an access to your node on tor using hidden services than to build this network. |



  

### Goals

anonymworld is a network that, in addition to Tor hidden services, also
indexes the normal web and only is reachable through Tor.

### Differences

The following changes from the above described procedure have to be
made:

1.  No whitelist: All whitelist/blacklist entries as well as the
    additional Jar-file are not necessary.
2.  Independent network: There are special unit and group files.

**Important:** This are the differences from the general description\!

#### Unit/Group-Files

The current definitions can be downloaded from
[\[4\]](http://jarwf7lglg3lbujb.onion:8086/yacy.network.unit.tor) and
[\[5\]](http://jarwf7lglg3lbujb.onion:8086/yacy.network.group.tor).

yacy.network.group.tor is empty and yacy.network.unit.tor has the
following content:

    network.unit.name = anonymworld 
    network.unit.description = Yacy network for TOR https://www.torproject.org/ indexing whole world
    network.unit.domain = any
    network.unit.search.time = 4
    network.unit.dhtredundancy.junior = 1
    network.unit.dhtredundancy.senior = 3
    network.unit.bootstrap.seedlist0 =  http://jarwf7lglg3lbujb.onion:8086/seed.txt

### Demo Peers

Beware, peers might be down.

  - <http://jarwf7lglg3lbujb.onion:8086/>

### Seed files

Please only add well available seed files.

  - <http://jarwf7lglg3lbujb.onion:8086/seed.txt>

# External links

  - <https://www.awxcnx.de/tor-i2p-proxy-en.htm> - Proxy page for using
    and testing tor network (hidden services) without any own tor
    installation
  - <http://tor.eff.org/download.html.de> -- downloading Tor and
    installation hints for several operating-systems
  - <http://rabe.supersized.org/archives/683-Mini-DNS-Server-fuer-Tor.html>
    -- hints on the dns-problem and solving it (german)
  - <http://www.suma-lab.de:8080/Wiki.html?page=yacy-tor> -- another
    description for installing yacy-tor (german)
  - [core.onion - Build decentral search engine network to index hidden
    services](http://eqt5g4fuenphqinx.onion/talk/272)

## Documentation for newbies in the Tor world

  - <http://6sxoyfb3h2nvok2d.onion/tor/> -- Hidden-Wiki with a list of
    Hidden Services
  - <http://6sxoyfb3h2nvok2d.onion/tor/TorYaCyHowto> -- How-To at Hidden
    Wiki for using Tor and YaCy

_Converted from
<https://wiki.yacy.net/index.php?title=En:YaCy-Tor>, may be outdated_




