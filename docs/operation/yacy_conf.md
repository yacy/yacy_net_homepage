# YaCy config settings

You can fine-tune various settings of YaCy in the config file
`DATA/SETTINGS/yacy.conf`

You can also change all the settings in in administration interface: 
__Administration > System Administration > Advanced Properties__.

Some changes take effect only after restart, some are rewritten. The safest
way of changing the settings in config file is with yacy not running: stop
yacy, change the settings, and start again.

All the config file options and default values are listed in file
`defaults/yacy.init`.

Options are described on this page as:

`` setting.name = default_value ``



## System
``host = 0.0.0.0``
The network interface - this connector binds to as an IP address or a hostname

``port = 8090``
	port number where the server should bind to

``port.ssl = 8443``
	optional ssl port (https port) the server should bind to



``port.shutdown = -1``
	port to listen for a shutdown signal 
	( -1 = disable use of a shutdown port, 8005 = recommended default )





``upnp.enabled = true``
use UPnP [true/false]

``upnp.remoteHost = ``
remote host on UPnP device (for more than one connection)


` bindPort = `
sometimes you may want yacy to bind to another port, than the one reachable from outside.
then set bindPort to the port yacy should bind on, and port to the port, visible from outside

to run yacy on port 8090, reachable from port 80, set `bindPort=8090`,
`port=80` and use:

	`iptables -t nat -A PREROUTING -p tcp -s 192.168.24.0/16 --dport 80 -j DNAT --to 192.168.24.1:8090`

(of course you need to customize the ips)

### Paths settings
`indexPrimaryPath=DATA/INDEX` 
The path to the public reverse word index for text files (web pages).

The primary path is relative to the data root, the secondary path is an absolute path.
when the secondary path should be equal to the primary, it must be declared
empty.


`indexArchivePath=DATA/ARCHIVE`
the path to index archive dumps

`listsPath=DATA/LISTS`
the path to the LISTS files. Most lists are used to filter web content


`workPath=DATA/WORK`
path to additional databases, like messages, blog data and bookmarks

`skinPath=DATA/SKINS`
the path to the SKINS files.

`proxyYellowList=yacy.yellow`
the yellow-list; URL's elements
(the core of an URL; like 'yahoo' in 'de.yahoo.com')
appearing in this list will not get a manipulated user agent string





## Server

### Servlets

property that collects the names of all servlets that had been used so far
that is used to track if the user has already done some configuration steps
if the used missed configuration steps that should be done, then a help system
is possible which leads the used based on the list of servlets that had been used
the list distinguishes called and submitted servlets

`server.servlets.called =`

`server.servlets.submitted =`

### Server tracking

`server.maxTrackingTime = 3600000`
maximum time a track entry is hold in the internal cache
value is in milliseconds, default is one hour


`server.maxTrackingCount = 1000`
maximum number of tracks per host

`server.maxTrackingHostCount = 100`
maximum number of hosts that are tracked


`server.response.compress.gzip = true`
When set to true, enable gzip compression of HTTP responses when the
user-agent (browser, another YaCy peer or any kind of client) accept gzip
encoding (by including gzip in a 'Accept-Encoding' HTTP request header).
This adds some processing overhead, but reduces the amount of bytes sent over network.


`referrer.meta.policy=origin-when-cross-origin`
Global HTTP Referrer policy delivered by meta tag (see
https://www.w3.org/TR/referrer-policy/ for available policies).
Can be left empty : the browser should then fallback to the default
"no-referrer-when-downgrade" policy.
Be careful, some policies will also affect YaCy internal links :
"no-referrer", "same-origin", "origin" and "strict-origin".  This can be
useful for example when proxyURL.useforresults is set to true, to control
the referrer information initially sent by YaCy proxy when visiting search
results.




### Maximum file sizes

Since some users experience problems with too large files, the file size of
database files can be limited.  Larger files can be used to get a better IO
performance and to use less RAM; however, if the size must be limited
because of limitations of the file system, the maximum size can be set here

`filesize.max.win   = 2147483647`

`filesize.max.other = 8589934591`


## Network

### IP and port
`staticIP=`
staticIP if you have a static IP, you can use this setting


`publicPort=`
 if you use a different port to access YaCy than the one it listens on, you can use this setting



### Network Definition
There can be separate YaCy networks, and managed sub-groups of the general network.

The essentials of the network definition are attached in separate property files.

The property here can also be a url where the definition can be loaded.

In case of privately managed networks, this configuration must be changed BEFORE it is released
to the members of the separated network peers.

`network.unit.definition = defaults/yacy.network.freeworld.unit`

`network.unit.definition = defaults/yacy.network.webportal.unit`

`network.unit.definition = defaults/yacy.network.intranet.unit`

`network.unit.domain.nocheck = false`
Distinguish intranet/internet IPs.
If this setting is set to true, then only URL-Hashes with 'intranet'-Flag is created, even if the
url is in the internet. This can be done to enhance the crawling speed dramatically since a DNS-lookup
to check if a host is in the internet oder an intranet can be omited.
This option is only valid if the `network.unit.domain` property is set to
'any'.



`network.unit.agent =`
A client may have its own agent name. This name can be set by the user and is set to a random value
if not overwritten by the user. As an alternative, the name can be set with this property.
This option is only used if the value is non-empty.


`network.unit.protocol.https.preferred = false`
Prefer https for in-protocol operations when available on remote peers.

A distinct general setting is available to control whether https sould be used for remote search queries :
`remotesearch.https.preferred`

### Clusters within a network
Every network can have an unlimited number of clusters. Clusters may be also completely
sealed and have no connection to other peers. When a cluster does not use the
p2p protocol and the bootstraping mechanism to contact other peers, we call them
Robinson peers. They can appear in different 'visibilities':

 - `privatepeer`: no connection and no data exchange to any other peer

 - `privatecluster`: connections only to self-defined addresses (other peers in same mode)

 - `publiccluster`: like privatecluster, but visible and searcheable by public p2p nodes

 - `publicpeer`: a single peer without cluster connection, but visible for p2p nodes


All public robinson peers should use a peer tag string to be searcheable if in the
search request these tags appear

`cluster.mode=publicpeer`

`cluster.peers.yacydomain=localpeer.yacy`

`cluster.peers.ipport=localhost:8090`

`bootstrapLoadTimeout = 20000`
this is the time-out for loading of the seedlist files during bootstraping.
If the time-out is too short, there is the danger that the peer stays in virgin
mode.


`clientTimeout = 10000`
time-out of client control socket in milliseconds
since this applies only to the client-proxy connection,
it can be rather short


### TLS/SSL support

For a German manual see
http://yacy-websuche.de/wiki/index.php/De:Interface%C3%9CberHTTPS

English speaking user read below:

With this you can access your peer using https://localhost:8443

There are two possibilities to specify which certificate should be used by YaCy.

1) Create a new certificate:

 1.1) For testing purposes, you can create a keystore with a self-signed certificate, 
using the following command:

       `C:\> keytool -keystore mySrvKeystore -genkey -keyalg RSA -alias mycert`

 1.2) Then configure the keyStoreXXXX properties accordingly, e.g.

`keyStore = c:/yacy/DATA/SETTINGS/mySrvKeystore`

`keyStorePassword = mypwd`

2) Import an existing certificate:

Alternatively you can import an existing certificate in pkcs12 format into the Java keystore.
    
This can be done by setting the pkcs12XXX and keyStoreXXXX properties accordingly, e.g.

`pkcs12ImportFile = c:/temp/keystore.pkcs12`

`pkcs12ImportPwd = test`

`keyStore = DATA/SETTINGS/keystore.jks`

`keyStorePassword = mypwd`


If the property keyStore is not specified, then a new keystore file 
`DATA/SETTINGS/myPeerKeystore` will be created.

 
`keyStore=defaults/freeworldKeystore`
Path to the Java KeyStore (JKS) holding the certificate to use when TLS/SSL is enabled on the server
(`server.https=true`)


keyStorePassword=freeworld
Password to access the Java KeyStore (JKS)


`pkcs12ImportFile =`
Path to a PKCS *12 keystore holding a certificate to import into the Java KeyStore
This property is automatically reset to empty once the import has been successfully completed

`pkcs12ImportPwd = `
Password to access a PKCS *12 keystore holding a certificate to import
This property is automatically reset to empty once the import has been successfully completed


The Java KeyStore is only used, if `server.https` is set to `true`.

If `server.https=true`, then the YaCy web interface is available at
https://localhost:<port.ssl>/ and at http://localhost:<port>/
`server.https=false`




## Update process
The update server location is given in the network.unit.definition,
but the settings for update processing and cycles are individual.

`update.process = manual`
 the update process can be either:

 * `manual` (no automatic lookup for new versions),
 * `guided` (automatic lookup, but user is asked before update is performed',
 * or `auto` (whenever an update is available, the update is loaded and
 installed).


`update.cycle = 168`
the cycle value applies only if the process is automatic or guided. The value means hours.
There is currently a fixed minimum number of hours of 24 hours for updates


`update.blacklist = `
a version number blacklist can restrict automatic or guided updates to a specific
range of version numbers. The restriction is done with a blacklist (standard regexpr)
It is recommended to set this list to low developer version numbers

`update.concept = any`
a update can also restricted with a concept property, which can decide if an
update is only valid if it either is a main release or any release including new development
releases.
Valid keywords are `main` and `any`.


the following values are set automatically:

`update.time.lookup = 0`
 the lookup time when the last time a lookup to the network update server(s) where done 

`update.time.download = 0`
the download time when the last time a release was downloaded

`update.time.deploy = 0`
the deploy time when the last update was done; milliseconds since epoch

`update.deleteOld = 30`
delete old downloaded files after this amount of days to free disk space.
the latest release is always kept.


`update.onlySignedFiles = 1`
only install sign files

`releases = DATA/RELEASE`
storage place for new releases



## Restart-option
a peer can be re-started periodically

`restart.process` can be either `off` (no automatic restart) or `time` (time- rule-based, see below)

`restart.process = off`

`restart.cycle = 20`
the number of hours that must pass before a restart is done

`restart.hour = 03`
the restart.hour is a pattern that must match with the hour string (two-digit, 24h)
when the restart should be performed

`restart.time = 0`
this value is set automatically





## HTTP options

`httpdMaxBusySessions = 200`
maximal number of httpd sessions.
a client may open several connections at once, and the httpdMaxBusySessions value sets
a limit on the number of concurrent connections

`http.outgoing.pool.general.maxTotal = 200`
maximum number of simultaneously open outgoing HTTP connections in the general pool (net.yacy.cora.protocol.http.HTTPClient)

`http.outgoing.pool.remoteSolr.maxTotal = 100`
maximum number of simultaneously open outgoing HTTP connections in the remote Solr pool (net.yacy.cora.federate.solr.instance.RemoteInstance)

`htRootPath = htroot`
default root path for the file server.
may be overridden by the htdocs parameter.
users shall be encouraged to use the htdocs path for individual content,
not this path defined here.

`htDefaultPath=htroot`.
the htroot path.
root path for the httpd file server.

`htDocsPath = DATA/HTDOCS`
individual htroot folder.
every user may publicize her/his own web pages.
these pages shall be placed in the path defined here.
the htdocs path shares its content with the htroot path.

`defaultFiles = index.html,index.htm,default.html,search.html,console.html,control.html,welcome.html,wiki.html,forum.html,blog.html,email.html,content.html,monitor.html,share.html,dir.html,readme.txt`
the default files (typically index.html), if no file name is given.
The complete path to this file is created by combination with the
rootPath.
You can set a list of defaults, separated by comma, the first one is
preferred.




### TLS Server Name Indication (SNI) extension support for outgoing HTTP connections

Must be enabled to load some https URLs (for websites deployed with
different certificats and host names on the same shared IP address),
otherwise loading fails with errors such as "Received fatal alert:
handshake_failure".

It can be necessary to disable it to load some https URLs served by old and
misconfigured web servers, otherwise loading fails with the exception
`javax.net.ssl.SSLProtocolException: "handshake alert:  unrecognized_name"`.

In 2019, this last error should occur less frequently as in the early days
of the extension implementation as its standard definition has evolved from
RFC 4366 to RFC 6066 which revised how server implementations should handle
the unrecognized_name(112) alert.  

Can also be configured with the JVM option `jsse.enableSNIExtension`, but in
that case a server restart is required when you want to modify the setting
and it is not customizable per http client (general or for remote Solr)

`http.outgoing.general.tls.sniExtension.enabled = true`
Set to true to enable TLS Server Name Indication (SNI) extension on outgoing
HTTP connections in the general http client
(`net.yacy.cora.protocol.http.HTTPClient`)

`http.outgoing.remoteSolr.tls.sniExtension.enabled = true`
Set to true to enable TLS Server Name Indication (SNI) extension on outgoing
HTTP connections in the remote Solr http client
(`net.yacy.cora.federate.solr.instance.RemoteInstance`)



### virtual host for httpdFileServlet access

for example http://<fileHost>/ shall access the file servlet and
return the defaultFile at rootPath

either way, http://<fileHost>/ denotes the same as http://localhost:<port>/
for the preconfigured value 'localpeer', the URL is:
`http://localpeer/`

`fileHost = localpeer`

`mimeTable = defaults/httpd.mime`
specify the path to the MIME matching file table

`sessionidNamesFile = defaults/sessionid.names`
specify the path to the sessionid name file







## Locale options

YaCy supports localization.

Web pages for special languages are located in the `htLocalePath`

The `htLocaleLang` defines a list of language options as
`<dir>/<named-language>`.

The `<dir>` must exist as sub-path to htLocalePath.

The `htLocaleSelection` selects from the given locales,
`value=one-of-<dir>`.

`locale.source=locales`

`locale.translated_html=DATA/LOCALE/htroot`

`locale.language=default`





## Proxy cache

`proxyCache = DATA/HTCACHE`
a path to the file cache, used for the internal proxy and as crawl buffer
This will be used if the server is addressed as a proxy

`proxyCacheSize = 4096`
the maximum disc cache size for files in Cache in megabytes.
default: 4 Gigabyte.

`proxyCache.compressionLevel = 9`
The compression level for cached content.
Supported values ranging from `0` - no compression (lower CPU, higher disk
usage), to `9` - best compression (higher CPU, lower disk use).


`proxyCache.sync.lockTimeout = 2000`
Timeout value (in milliseconds) for acquiring a synchronization lock on
getContent/store Cache operations.
When timeout occurs, loader should fall back to regular remote resource
loading.

`proxyAlwaysFresh = false`
you can use the proxy with fresh/stale rules or in a always-fresh mode



## Surrogates
`surrogates.in = DATA/SURROGATES/in`
a path to the surrogate input directory

`surrogates.out = DATA/SURROGATES/out`
a path to the surrogate output directory




## Data enhancements
`dictionaries = DATA/DICTIONARIES`
a path to the dictionaries directory.
This directory also contains subdirectories for input sources, the did-you-mean function and other

`vocabularies.matchLinkedData.names =`
Set of comma separated vocabulary names whose terms should only be matched 
from linked data types annotations in documents (with microdata, RDFa, microformats...) 
instead of cleartext words


`classification = DATA/CLASSIFICATION`
a path to the classification directory.
Each subdirectory is the name of a context (which becomes a navigator) with '.txt' files
containing texts to teach a bayesian filter. One of the files must be named 'negative.txt'.
The text files can be created with the Export functionality using the option "Only Text".




## Parser settings
the following mime-types are a blacklist for indexing:

`parser.mime.deny=`
parser.mime.deny: specifies mime-types that shall not be indexed

`parser.extensions.deny=iso,apk,dmg`

`parser.enableAudioTags=false`
The audioTagParser is disabled by default as it needs to create a temporary file each time an audio resource is
parsed.
Audio file extensions and media types can be enabled in the ConfigParser_p.html page if this is not a problem with your
install.


experimental single-page parser for pdf files: split one pdf into individual pages;
the key is the property name in the post arguments that gets a page number assigned,
page numbers start with 1.

`parser.pdf.individualpages=false`

`parser.pdf.individualpages.key=page`


## Promotion Strings

These strings appear in the Web Mask of the YACY search client.

Set these Strings to cusomize your peer and give any message to other peer
users:

`promoteSearchPageGreeting = Web Search by the People, for the People`

`promoteSearchPageGreeting.useNetworkName = false`
if set to true, the network name is used as greeting



The following attributes can be used to define a custom image, alternative
text and home page on the search page:

`promoteSearchPageGreeting.homepage = https://yacy.net`

`promoteSearchPageGreeting.imageAlt = YaCy project web site`

`promoteSearchPageGreeting.largeImage = env/grafics/YaCyLogo_120ppi.png`

`promoteSearchPageGreeting.smallImage = env/grafics/YaCyLogo_60ppi.png`




## Black-lists

the black-list; URLs appearing in this list will not be loaded;
instead always a 404 is returned

all these files will be placed in the listsPath

`BlackLists.Shared=url.default.black`

`BlackLists.DefaultList=url.default.black`

these are not needed as default. they just keep the values from beeing deleted
...:

`proxy.BlackLists=url.default.black`

`crawler.BlackLists=url.default.black`

`dht.BlackLists=url.default.black`

`search.BlackLists=url.default.black`

`surftips.BlackLists=url.default.black`

`news.BlackLists=url.default.black`


`plasmaBlueList=yacy.blue` 
the blue-list; 
no search result is locally presented that has any word of the bluelist
in the search words, the URL or the URL's description




## Proxy settings

this proxy may in turn again access another proxy

if you wish to do that, specify it here

if you want to switch on the proxy use, set `remoteProxyUse=true`

`remoteProxyNoProxy` is a no-proxy pattern list for the remote proxy

`remoteProxyUse=false`

`remoteProxyUse4SSL=true`

`remoteProxyHost=192.168.2.2`

`remoteProxyPort=4239`

`remoteProxyUser=`

`remoteProxyPwd=`

`remoteProxyNoProxy=10\..*,127\..*,172\.(1[6-9]|2[0-9]|3[0-1])\..*,169\.254\..*,192\.168\..*,localhost,0:0:0:0:0:0:0:1`


`proxyBlueList=yacy.blue`
the proxy may filter the content of transferred web pages.
The bluelist removes specific keywords from web pages.


### Security settings
we provide proxy and server security through a 2-stage security gate:

* 1st stage: firewall-like access control trough ip filter for clients

* 2nd stage: password settings for proxy, server and server administrators

By default, these settings are weak to simplify set-up and testing
every user/adiministrator shall be encouraged to change these settings.

your can change them also online during run-time on http://localhost:8090/.

`proxyClient=localhost,127\.0\.0\.1,192\.168\..*,10\..*,0:0:0:0:0:0:0:1.*`
client-ip's that may connect the proxy for proxy service.
if several ip's are allowed then they must be separated by a ','.
regular expressions may be used.


`YaCyHop=true`
allow public usage of proxy for yacy-protocol.
this enables usage of the internal http proxy for everyone,
if the file path starts with /yacy/.
This is used to enable anonymization of yacy protocol requests.
Instead of asking a remote peer directly, a peer in between is asked
to prevent that the asked peer knows which peer asks.


`serverClient=*`
serverClient: comma separated client-ip's that may connect to the web server,
thus are allowed to use the search service.
if you set this to another value, search requests from others
are blocked, but you will also be blocked from using others
search services.



`use_proxyAccounts=true`
set to true to restrict proxy-access to some identified users.
use User_p.html to create some Users.




## Users and passwords

`adminAccountBase64MD5`: a encoded user:password - pair

For the administration of settings through the web interface.
Should be set to a secret.
but you are encouraged to set it to another value on the page
http://localhost:8090/ConfigAccounts_p.html

The hash is calculated with net.yacy.cora.order.Digest, i.e.

	`java -classpath classes net.yacy.cora.order.Digest -strfhex "admin:<realm>:<pw>"`

(adminAccountBase64=MD5:{admin:realm:mysecretpassword})

The default password for the "admin" account is set to "yacy":

`adminAccountUserName=admin`

`adminAccountBase64MD5=MD5:8cffbc0d66567a0987a4aba1ec46d63c`

Special access handling for users from localhost:

`adminAccountForLocalhost=true`
access from localhost may be granted with administration authority
if this flag is set. It is set to true by default to make usage of YaCy easy
if you use YaCy on a headless server, you should set this to false
or configure this on http://localhost:8090/ConfigAccounts_p.html
during the first 10 minutes of operation of YaCy;
if the admin account password is still empty after 10 minutes a random
password is generated an access is then ONLY from localhost, which will cause
inaccessibility for installations on headless servers.

`adminAccountAllPages=false`
adminAccountAllPages: if set to false, then all pages without the extension "_p" are
accessible without authorization. Some servlets may individually decide to use or request
administration rights. If adminAccountAllPages is set to true, then administration
rights are needed to access all pages without any exception. Setting adminAccountAllPages
to true therefore closes the YaCy web pages for everyone.



`adminRealm=The YaCy access is limited to administrators. If you don't know the password, you can change it using <yacy-home>/bin/passwd.sh <new-password>`
adminRealm: a internal name (like a group name) for the login setting of the admin
frontend.

**ATTENTION**: changing this name will invalidate all currently password hashes
- With DIGEST authentication mode is this realm name of generated password hashes
  (RFC 2617 standard and recommendation). If you want to share password configuration 
  with additional machines they have to belong to the same realm
- authentication defaults to BASIC 
- and can be configured in defaults/web.xml , tag <auth-method>





## Seeds and peers settings

If you are running a principal peer, you must update the following
variables.

The upload method that should be used to upload the seed-list file to
a public accessible webserver where it can be loaded by other peers.

You can set the `seedUploadMethod`-Property to:

- `None`

- `Ftp`

- `File`

- `Scp` (only if you have installed the optional addon)

`seedUploadMethod=none`

This is the most common method to upload the seed-list.
 
This is an ftp account with all relevant information.

The update is only made if there had been changes in between:

`seedFTPServer=`

`seedFTPAccount=`

`seedFTPPassword=`

`seedFTPPath=`

`seedFilePath=`
alternatively to an FTP account, a peer can also become a principal peer
if the seed-list can be generated as a file and that file is also accessible from
the internet. In this case, omit any ftp settings and set this path here.
if this path stays empty, an ftp account is considered.
however, you must always set a seedURL because it is used to check if the
file is actually accessible from the internet.



Settings needed to upload the seed-list file via scp:

`seedScpServer=`

`seedScpServerPort=`

`seedScpAccount=`

`seedScpPassword=`

`seedScpPath=`

Please note that this upload method can only be used if you have installed
this optional upload method.




`scan.peerCycle=2`
every peer periodically scans for other peers. you can set the time
of the period here (minutes).

`scan.enabled=false`
You might switch it on in kubernetes clusters:







## OS integration

each time YaCy starts up, it can trigger the local browser to show the
status page. This is active by default, to make it easier for first-time
users to understand what this application does. You can disable browser
pop-up here or set a different start page, like the search page:

`browserPopUpTrigger=true`

`browserPopUpPage=index.html`


`indexForward =`
a forward page can be given for the index.html page.
when a user accesses the index.html page, he/she is forwarded to the page
as given by indexForward. This is by default not defined which means 'no forward'



Defines if the YaCy icon appears in the system tray on supported platforms:

`tray.icon.enabled=true`

`tray.icon.force=false`

`tray.icon.label=YaCy`

`tray.menu.enabled=true`


## Index sharing attributes

by default, sharing is on.

If you want to use YaCy only for local indexing (robinson mode), you may switch this
off.

`allowDistributeIndex=true`

`allowDistributeIndexWhileCrawling=false`

`allowDistributeIndexWhileIndexing=true`

`allowReceiveIndex=true`

`allowReceiveIndex.search=true`

`indexReceiveBlockBlacklist=true`



the frequency is the number of links per minute, that the peer allows
_every_ other peer to send to this peer:

`defaultWordReceiveFrequency=100`

`defaultLinkReceiveFrequency=30`

The default may be overridden for each peer individually, these
settings are only available through the online interface.


## Prefetch parameters

the prefetch depth assigns a specific depth to the prefetch mechanism
prefetch of 0 means no prefetch; a prefetch of 1 means to prefetch all
embedded URLs, but since embedded image links are loaded by the browser
this means that only embedded anchors are prefetched additionally
a prefetch of 2 would result in loading of all images and anchor pages
of all embedded anchors. Be careful with this value, since even a prefetch
of 2 would result in hundreds of prefetched URLs for each single proxy fill.

`proxyPrefetchDepth=0`

`proxyStoreHTCache=true`

`proxyIndexingRemote=false`

`proxyIndexingLocalText=true`

`proxyIndexingLocalMedia=true`

`proxyYacyOnly=false`
proxy usage only for .yacy-Domains for autoconfig

`proxyURL=false`
enable proxy via url (/proxy.html?url=http://yacy.net)

`proxyURL.access=127.0.0.1,0:0:0:0:0:0:0:1`

`proxyURL.rewriteURLs=domainlist`
which urls to rewrite to /proxy.html?url=x (values: all, domainlist)

`proxyURL.useforresults=false`







## Crawling
From the 'IndexCreate' menu point you can also define a crawling start point.

The crawling works the same way as the prefetch, but it is possible to
assign a different crawling depth.

Be careful with this number. Consider a branching factor of average 20;
A prefetch-depth of 8 would index 25.600.000.000 pages, maybe the whole WWW.

`crawlingDepth=3`

`crawlingDirectDocByURL=true`

`crawlingIfOlder=-1`

`crawlingDomFilterDepth=-1`

`crawlingDomMaxPages=-1`

`indexText=true`

`indexMedia=true`

Filter for crawling; may be used to restrict a crawl to a specific domain:

`crawlingFilter=.*`
URLs are only indexed and further crawled if they match this filter

`crawlingQ=true`

`followFrames=true`

`obeyHtmlRobotsNoindex=true`

`obeyHtmlRobotsNofollow=false`

`storeHTCache=true`

`storeTXCache=true`


### Remote Crawl
peers may initiate remote crawling tasks.

every peer may allow or disallow to be used as crawling-peer;
you can also set a maximum crawl depth that can be requested or accepted
order=parameters for requester; response=parameters for responder

these values apply only for senior-senior - communication

The delay value is number of seconds bewteen two separate orders

crawlOrder: default value for remote crawl starts

crawlResponse: set to true if a peer should retrieve remote crawl urls from other peers

`crawlOrder=true`

`crawlOrderDepth=0`

`crawlResponse=false`

`crawlResponseDepth=0`


### Custom user agents

Custom user agents for 'allip' networks:

This user agent is only available if the network is set to 'allip' (which is a non-limited domain 'network'
without p2p options). Changing this will NOT change the default YaCy user agent, it will only provide an
agent which is available at crawl start within 'allip'. The userAgent.name is the identifier for the
robots.txt file which YaCy always obeys for the given name or a wildcard for robot types.

If any part of this custom user agent name or string includes the phrase 'yacy', it will be IGNORED
to prevent fraud, DoS or bad behavior in the name of YaCy.

To use this user agent option, you must define completely different names and strings
and remove the given example here, which will be ignored by default.

`crawler.userAgent.name = yacybot`

`crawler.userAgent.string = yacybot ($$SYSTEM$$) http://yacy.net/bot.html`

`crawler.userAgent.minimumdelta = 500`

`crawler.userAgent.clienttimeout = 10000`

`timeoutrequests = true`
experiments with timeout requests


### Indexing-exclusion - rules
There rules are important to reduce the number of words that are indexed.

We distinguish three different sets of stop-words:

* static   - excludes all words given in the file yacy.stopwords from indexing,

* dynamic  - excludes all words from indexing which are listed by statistic rules,

* parental - excludes all words from indexing which had been indexed in the parent web page.

`xsstopw=true`

`xdstopw=true`

`xpstopw=true`

`filterOutStopwordsFromTopwords=true`
Topwords filtering.
If set to `true`, all stopwords (stopwords.yacy) are filtered from the
topwords.
Change to `false` if requesting hits from peers with modified stopwords-file and using the unchanged
client-version.


crawling steering: must-match/must-not-match:

`crawlingIPMustMatch=.*`

`crawlingIPMustNotMatch=`


`crawlingCountryMustMatch=AD,AL,AT,BA,BE,BG,BY,CH,CY,CZ,DE,DK,EE,ES,FI,FO,FR,GG,GI,GR,HR,HU,IE,IM,IS,IT,JE,LI,LT,LU,LV,MC,MD,MK,MT,NL,NO,PL,PT,RO,RU,SE,SI,SJ,SK,SM,TR,UA,UK,VA,YU`
The default country codes are all codes for countries in Europe


### Collections for index data separation

These collections can either be used to produce search tenants.

The collection is used in the site-parameter in the GSA interface.

Collections are assigned during crawl-time and defined in the crawl start.

The YaCyScheme field collection_sxt must be switched on to use this field.

`collection=user`


### Crawler limits
`crawlPause`: delay time after specific functions before crawling is resumed

`crawlPause.proxy=10`

`crawlPause.localsearch=50`

`crawlPause.remotesearch=10`


`crawler.clientTimeout=30000`
Some configuration values for the crawler


http crawler specific settings; size in bytes:

`crawler.http.accept=text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8`

`crawler.http.acceptEncoding=gzip`

`crawler.http.acceptLanguage=en-us,en;q=0.5`

`crawler.http.acceptCharset=ISO-8859-1,utf-8;q=0.7,*;q=0.7`

`crawler.http.maxFileSize=10485760`

`crawler.http.FollowRedirects=true`

`crawler.http.RecordRedirects=false`


`crawler.ftp.maxFileSize=10485760`
ftp crawler specific settings; size in bytes.


smb crawler specific settings: 

`crawler.smb.maxFileSize=100000000`
maximum size

`crawler.file.maxFileSize=100000000`
maximum file size

`crawler.MaxActiveThreads = 200`
maximum number of crawler threads

`crawler.MaxSameHostInQueue = 20`
maximum number of same hosts in crawler threads

`crawler.defaultAverageLatency = 500`
default latency is the start value  of the average of remote server response time

`crawler.latencyFactor = 0.5`
the latency factor is a factor that is applied to the average remote server latency.
The result is the minimum remote server access delay time.

`crawler.onDemandLimit = 1000`
The onDemandLimit is the maximum number of crawl queues that are concurrently opened
at the same time. If the number of hosts exceeds this number, onDemand queues are opened
which are opened each time a queue is accessed which creates high IO load. On the other
hand, having too many entries in onDemandLimit may exceed the maximum number of file
pointers. You can increase this number in /proc/sys/fs/file-max and adopt it to the number
defined here.


### Autocrawl configuration

`autocrawl=false`

`autocrawl.index.text=true`

`autocrawl.index.media=true`

`autocrawl.ratio=50`

`autocrawl.rows=100`

`autocrawl.days=1`

`autocrawl.query=*:*`

`autocrawl.deep.depth=3`

`autocrawl.shallow.depth=1`



## Performance settings
delay-times for permanent loops (milliseconds)

the `idlesleep` is the pause that an proces sleeps if the last call to the
process job was without execution of anything;

the `busysleep` is the pause after a full job execution

the `prereq-value` is a memory pre-requisite: that much bytes must
be available/free in the heap; othervise the loop is not executed
and another idlesleep is performed

`recrawlindex_busysleep=10`

`recrawlindex_idlesleep=2000`

`recrawlindex_loadprereq=8.0`

`recrawlindex_memprereq=1048576`

`20_dhtdistribution_idlesleep=30000`

`20_dhtdistribution_busysleep=15000`

`20_dhtdistribution_memprereq=12582912`

`20_dhtdistribution_loadprereq=2.0`

`30_peerping_idlesleep=30000`

`30_peerping_busysleep=30000`

`30_peerping_memprereq=2097152`

`30_peerping_loadprereq=4.0`

`40_peerseedcycle_idlesleep=1800000`

`40_peerseedcycle_busysleep=1200000`

`40_peerseedcycle_memprereq=4194304`

`40_peerseedcycle_loadprereq=2.0`

`50_localcrawl_idlesleep=2000`

`50_localcrawl_busysleep=10`

`50_localcrawl_memprereq=25165824`

`50_localcrawl_loadprereq=8.0`

`50_localcrawl_isPaused=false`

`55_autocrawl_idlesleep=10000`

`55_autocrawl_busysleep=10000`

`55_autocrawl_memprereq=25165824`

`55_autocrawl_loadprereq=8.0`

`60_remotecrawlloader_idlesleep=4000`

`60_remotecrawlloader_busysleep=800`

`60_remotecrawlloader_memprereq=12582912`

`60_remotecrawlloader_loadprereq=8.0`

`60_remotecrawlloader_isPaused=false`

`62_remotetriggeredcrawl_idlesleep=2000`

`62_remotetriggeredcrawl_busysleep=200`

`62_remotetriggeredcrawl_memprereq=12582912`

`62_remotetriggeredcrawl_loadprereq=8.0`

`62_remotetriggeredcrawl_isPaused=false`

`70_surrogates_idlesleep=10000`

`70_surrogates_busysleep=0`

`70_surrogates_memprereq=12582912`

`70_surrogates_loadprereq=8.0`

`720_ccimport_idlesleep=100`

`720_ccimport_busysleep=1000`

`720_ccimport_memprereq=1048576`

`720_ccimport_loadprereq=8.0`

`730_ccfilter_idlesleep=100`

`730_ccfilter_busysleep=1000`

`730_ccfilter_memprereq=1048576`

`730_ccfilter_loadprereq=8.0`

`85_scheduler_idlesleep=60000`

`85_scheduler_busysleep=60000`

`85_scheduler_memprereq=1048576`

`85_scheduler_loadprereq=4.0`


`90_cleanup_idlesleep=300000`

`90_cleanup_busysleep=300000`

`90_cleanup_memprereq=0`

`90_cleanup_loadprereq=16.0`


`reindexSolr_idlesleep=1000`

`reindexSolr_busysleep=1`

`reindexSolr_memprereq=10485760`

`reindexSolr_loadprereq=16.0`


### Performance settings
performanceIO is a percent-value. a value of 10 means, that 10% of the busysleep time
is used to flush the RAM cache, which is the major part of the IO in YaCy:

`performanceProfile=defaults/yacy.init`

`performanceSpeed=100`

`performanceIO=10`


### Cleanup process
properties for tasks that are performed during cleanup

`cleanup.deletionProcessedNews = true`

`cleanup.deletionPublishedNews = true`

`cleanup.failedSearchURLtimeout = 86400000`


### Memory settings
default memory settings for startup of yacy is valid in unix/shell and
windows environments but not for first startup of YaCy

`javastart_Xmx=Xmx600m`
-Xmx<size> maximum/init Java heap size


YaCy is able to use RAM copies of database tables. This needs a lot of RAM.
To switch on copying of file tables int RAM, there must be enough memory
The memory that is available at startup time is used to switch the feature on

`tableCachingLimit=419430400`
The tableCachingLimit is the amount of free RAM at startup time to switch on the feature


some java versions may be limited to a specific array size
of 134217727 entries. To prevent that tables of that size are generated,
set this property to false

If you want to have better performance and switch ramcopy on, try also to
set this property to true

`exceed134217727=false`
this value is automatically set to true, if more than two gigabyte is available


`javastart_priority=10`
priority of the yacy-process.
Is valid in unix/shell and windows environments but not for first startup of
YaCy.
UNIX: corresponds to the nice-level.
WIN: -20=realtime;-15=high;-10=above;0=normal;10=below;20=low.


`wordCacheMaxCount = 20000`
performance properties for the word index cache.
wordCacheMaxLow/High is the number of word indexes that shall be held in the
ram cache during indexing. If you want to increase indexing speed, increase this
value i.e. up to one million, but increase also the memory limit to a minimum of 2GB.



## Transparent proxy

`isTransparentProxy=false`
Specifies if yacy can be used as transparent http proxy.

Please note that you also have to reconfigure your firewall
before you can use yacy as transparent proxy. On linux this
can be done like this:
`   iptables -t nat -A PREROUTING -p tcp -s 192.168.0.0/16 \
   --dport 80 -j DNAT --to 192.168.0.1:8090`

With the iptables filter listed above all http traffic that
comes from your private network (in this case 192.168.0.0)
and goes to any webserver listening on port 80 will be forwarded
by the firewall to yacy running on port 8090 (192.168.0.1:8090)


`proxy.clientTimeout = 60000`
Specifies the timeout the proxy sould use


`proxy.sendViaHeader=true`
Specifies if the proxy should send the via header according to RFC


`proxy.sendXForwardedForHeader=true`
Specifies if the proxy should send the X-Forwarded-For header



`proxy.monitorCookies=false`
Enable cookie monitoring



## Message Forwarding
Specifies if yacy should forward received messages via
email to the configured email address

`msgForwardingEnabled=false`

`msgForwardingCmd=/usr/sbin/sendmail`

`msgForwardingTo=root@localhost`





## Indexing

`snapshots.wkhtmltopdf.timeout = 30`
The maximum time in seconds to wait for each wkhtmltopdf call when rendering PDF
snapshots.
Beyond that limit the process is killed.


`indexer.slots = 100`
maximum size of indexing queue

`stacker.slots = 2000`
maximum size of stacker queue



## Search settings

`search.options = true`
show advanced options on main search page


search domains. If set to false then that search is not available:

`search.text = true`

`search.image = true`

`search.audio = false`

`search.video = false`

`search.app = false`



### Strict content domain filtering 
 
when false, results can be extended to documents including links to documents
of contentdom type, whithout being themselves of that type.

Examples:

 * contentdom search param == image, strictContentDom == true

 	* jpeg image : acceptable result

 	* html page embedding images : rejected

 * contentdom search param == image, strictContentDom == false

 	* jpeg image : acceptable result

 	*  html page embedding images : acceptable result

`search.strictContentDom = false`

`search.items = 10`
number of search results per page displayed by default


### Target for search results

this is the href target attribute inside every search result link.

Possible values:

* `_blank` (new window), `_self` (same window), `_parent` (the parent frame of a frameset),

* `_top` (top of all frames), `searchresult` (a default custom page name for search results)

* a special pattern can be given for exceptions to the default target according to
  urls.

`search.target = _self`

`search.target.special = _self`

`search.target.special.pattern =`


`search.result.noreferrer=false`
When true, override the global referrer.meta.policy value and add the standard noreferrer link type to search results links : 
this instructs the browser that it should not send any referrer information at all when visiting
them.
Be careful: some websites might reject requests with no referrer.
Supported by more browsers than the meta referrer tag.


### Additional search page information

Search result lines may show additional information for each search hit.

These information pieces may be switched on or off.

`search.result.show.favicon = true`
When true the favicon (when available) of the website the URL belongs to is fetched and displayed

`search.result.show.keywords = false`

`search.result.keywords.firstMaxCount = 100`
Maximum number of keywords initially displayed. The eventual remaining ones can then be expanded.


`search.result.show.date = true`

`search.result.show.size = false`

`search.result.show.metadata = false`

`search.result.show.parser = false`

`search.result.show.citation = true`

`search.result.show.pictures = false`

`search.result.show.cache = true`

`search.result.show.proxy = false`

`search.result.show.indexbrowser = true`

`search.result.show.vocabulary = false`


`search.result.show.vocabulary.omit = `
Set of comma separated vocabulary names not to be used as search results facets

`search.result.show.snapshots = false`

search.result.show.ranking = false
`when true, display the raw ranking score value`


### Access limits

Maximum numbers of accesses within a given time period to the search
interface for unauthenticated users and authenticated users with no extended
search right:

`search.public.max.access.3s = 60`

`search.public.max.access.1mn = 600`

`search.public.max.access.10mn = 3000`

Maximum numbers of accesses within a given time period to the search
interface in P2P mode for unauthenticated users and authenticated users with
no extended search right:

`search.public.max.p2p.access.3s = 1`
`search.public.max.p2p.access.1mn = 6`
`search.public.max.p2p.access.10mn = 60`


Maximum numbers of accesses within a given time period to the search
interface in P2P mode with browser-side JavaScript remote results resorting
for unauthenticated users and authenticated users with no extended search
right:

`search.public.max.p2p.jsresort.access.3s = 1`

`search.public.max.p2p.jsresort.access.1mn = 1`

`search.public.max.p2p.jsresort.access.10mn = 10`


Maximum number of accesses within a given time period to the search
interface to support fetching remote results snippets for unauthenticated
users and authenticated users with no extended search right

`search.public.max.remoteSnippet.access.3s = 1`

`search.public.max.remoteSnippet.access.1mn = 4`

`search.public.max.remoteSnippet.access.10mn = 20`



### Search navigators

comma-separated list of default values for search navigation.

By default navigators keys are sorted by descending counts. To sort by ascending displayed labels, add the :label suffix (example : hosts:label). 

The sort direction can also be specified with the :asc or :desc suffixes (example : hosts:label:desc)
can be temporary different if search string is given with different navigation values
assigning no value(s) means that no navigation is shown.

`search.navigation=location,hosts,authors,namespace,topics,filetype,protocol,language`

`search.navigation=location,hosts:label,authors,namespace,topics,filetype,protocol,language,collections,date,year,year:dates_in_content_dts:Event`
A lot of navigation shown

`search.navigation.maxcount=100`
max number of items displayed in search navigators


`search.navigation.dates.maxcount=640`
max number of items displayed in the dates navigator



### Search result verification and snippet fetch caching rules

each search result can be verified byloading the link from the web.

this can be enhanced using a cache. In some cases it may be appropriate
to not verify the link at all and do not compute a snippet
the possible cases are:

* `nocache`:   no use of web cache, load all snippets online

* `iffresh`:   use the cache if the cache exists and is fresh otherwise load online

* `ifexist`:   use the cache if the cache exist or load online

* `cacheonly`: never go online, use all content from cache.  If no cache entry
            exist, consider content nevertheless as available and show
            result without snippet

* `false`:     no link verification and not snippet generation: all search
            results are valid without verification

`search.verify = ifexist`

`search.excludehosts=`

`search.excludehosth=`


`search.verify.delete = true`
in case that a link verification fails then the corresponding index reference can be
deleted to clean up the index. If this property is set then failed index verification in
the cases of nocache, iffresh and ifexist causes an index deletion

`search.jsresort = false`
If enabled, the results are sorted in the browser using Javascript.
This usually improves ranking accuracy, but doesn't work well for users
who have Javascript disabled, are using screen readers, or are on slow computers.



### Remote search details

`remotesearch.maxcount = 10`

`remotesearch.maxtime = 3000`

`remotesearch.result.store=true`

`remotesearch.result.store.maxsize=-1`
Maximum size allowed (in bytes) for a remote document result to be stored to local index. Defaults to -1, which means no
limit.

`remotesearch.maxload.rwi=8.0`
`remotesearch.maxload.solr=4.0`


`remotesearch.https.preferred = false`
When available on the target peer, whether https should be preferred to perform remote search

`remote.solr.binaryResponse.enabled=true`
Controls whether remote Solr instances responses should be binary encoded. Responses are transferred as XML when set to false. 


`useYacyReferer = false`
specifies if yacy should set it's own referer if no referer URL
was set by the client.


### Search Profiles 
we will support different search profiles

If this profile setting is empty, a hard-coded profile is used to initialise the values
`search.ranking.rwi.profile =`

The boost fields contains all fields which shall be searched together with a
boost.  non-mentioned fields are not searched.

Boost queries are added to all queries; functions evaluate a value which is
either added or multiplied with the ranking.

The field boostfunctionmode can be either 'add' or 'multiply' to describe the mode.

All boost methods > 0 must have names to be able to select this name with a query, with the syntax /name

The bostfields setting is of special importance as these are the fields used
to query for search terms

`search.ranking.solr.collection.boostname.tmpa.0=Default Profile`

`search.ranking.solr.collection.boostfields.tmpa.0=url_paths_sxt^3.0,synonyms_sxt^0.5,title^5.0,text_t^1.0,host_s^6.0,h1_txt^5.0,url_file_name_tokens_t^4.0,h2_txt^3.0,keywords^2.0,description_txt^1.5,author^1.0`

`search.ranking.solr.collection.filterquery.tmpa.0=`

`search.ranking.solr.collection.boostquery.tmpa.0=crawldepth_i:0^0.8\ncrawldepth_i:1^0.4`

`search.ranking.solr.collection.boostfunction.tmpb.0=`

`search.ranking.solr.collection.boostname.tmpa.1=Date Profile: sort by date in descending order for a '/date' usage`

`search.ranking.solr.collection.boostfields.tmpa.1=url_paths_sxt^0.1,title^0.1,text_t^0.1`

`search.ranking.solr.collection.filterquery.tmpa.1=`

`search.ranking.solr.collection.boostquery.tmpa.1=`

`search.ranking.solr.collection.boostfunction.tmpb.1=recip(ms(NOW,last_modified),3.16e-11,1,1)`

`search.ranking.solr.collection.boostname.tmpa.2=Intranet Profile: when a search is done on a single domain only, i.e. if a site:-operator is used`

`search.ranking.solr.collection.boostfields.tmpa.2=url_paths_sxt^3.0,synonyms_sxt^0.5,title^5.0,text_t^1.0,h1_txt^5.0,url_file_name_tokens_t^4.0,h2_txt^3.0,h3_txt^2.0,keywords^2.0,description_txt^1.5,author^1.0`

`search.ranking.solr.collection.filterquery.tmpa.2=`

`search.ranking.solr.collection.boostquery.tmpa.2=fuzzy_signature_unique_b:true^10.0`

`search.ranking.solr.collection.boostfunction.tmpb.2=`

`search.ranking.solr.collection.boostname.tmpa.3=_unused3`

`search.ranking.solr.collection.boostfields.tmpa.3=text_t^1.0`

`search.ranking.solr.collection.filterquery.tmpa.3=`

`search.ranking.solr.collection.boostquery.tmpa.3=crawldepth_i:0^0.8\ncrawldepth_i:1^0.4`

`search.ranking.solr.collection.boostfunction.tmpb.3=`


the following values are used to identify duplicate content:

`search.ranking.solr.doubledetection.minlength=3`

`search.ranking.solr.doubledetection.quantrate=0.5f`



Another attribute for double content is a 'greedy' ignoring of a http url is present for each https and vice
versa.

The same may be true for documents with leading 'www.' subdomain and without.

The following attributes will cause that https is preferred over http and with-www is preferred over
without-www:

`search.ranking.uniqueheuristic.preferhttps = false`

`search.ranking.uniqueheuristic.preferwwwprefix = true`

`thumbnailProgram = `
optional external thumbnail program.
The program must accept the invocation `PROGRAM http://url /path/to/filename`.




### Search sequence settings

**collection:**

* time = time to get a RWI out of RAM cache, assortments and WORDS files

* count = maximum number of RWI-entries that shall be collected


**join:**

* time = time to perform the join between all collected RWIs

* count = maximum number of entries that shall be joined



**presort:**

* time = time to do a sort of the joined URL-records

* count = maximum number of entries that shall be pre-sorted


**urlfetch:**

* time = time to fetch the real URLs from the LURL database

* count = maximum number of urls that shall be fetched


**postsort:**

* time = time for final sort of URLs

* count = maximum number of URLs that shall be retrieved during sort


**filter:**

* time = time to filter out unwanted urls (like redundant urls)

* count = maximum number of urls that shall be filtered


**snippetfetch:**

* time = time to fetch snippets for selected URLs

* count = maximum number of snipptes to be fetched


all values are percent:

* time-percent is the percent of total search time

* count-percent is the percent of total wanted urls in result

* we distinguish local and remote search times

`searchProcessLocalTime_c = 44`

`searchProcessLocalCount_c = 10000000`

`searchProcessLocalTime_j = 8`

`searchProcessLocalCount_j = 1000000`

`searchProcessLocalTime_r = 8`

`searchProcessLocalCount_r =100000`

`searchProcessLocalTime_u = 20`

`searchProcessLocalCount_u = 10000`

`searchProcessLocalTime_o = 10`

`searchProcessLocalCount_o = 100`

`searchProcessLocalTime_f = 5`

`searchProcessLocalCount_f = 100`

`searchProcessLocalTime_s = 5`

`searchProcessLocalCount_s = 30`

`searchProcessRemoteTime_c = 44`

`searchProcessRemoteCount_c = 1000000`

`searchProcessRemoteTime_j = 8`

`searchProcessRemoteCount_j = 1000000`

`searchProcessRemoteTime_r = 8`

`searchProcessRemoteCount_r = 1000`

`searchProcessRemoteTime_u = 20`

`searchProcessRemoteCount_u = 1000`

`searchProcessRemoteTime_o = 10`

`searchProcessRemoteCount_o = 1000`

`searchProcessRemoteTime_f = 5`

`searchProcessRemoteCount_f = 100`

`searchProcessRemoteTime_s = 5`

`searchProcessRemoteCount_s = 10`


timeouts for snippet fetching in ms:

timeout_text is for text-snippets, timeout_media for media, e.g. images:

`timeout_text = 10000`

`timeout_media = 15000`



`httpc.nameCacheNoCachingPatterns = .*.ath.cx,.*.blogdns.*,.*.boldlygoingnowhere.org,.*.dnsalias.*,.*.dnsdojo.*,.*.dvrdns.org,.*.dyn-o-saur.com,.*.dynalias.*,.*.dyndns.*,.*.ftpaccess.cc,.*.game-host.org,.*.game-server.cc,.*.getmyip.com,.*.gotdns.*,.*.ham-radio-op.net,.*.hobby-site.com,.*.homedns.org,.*.homeftp.*,.*.homeip.net,.*.homelinux.*,.*.homeunix.*,.*.is-a-chef.*,.*.is-a-geek.*,.*.kicks-ass.*,.*.merseine.nu,.*.mine.nu,.*.myphotos.cc,.*.podzone.*,.*.scrapping.cc,.*.selfip.*,.*.servebbs.*,.*.serveftp.*,.*.servegame.org,.*.shacknet.nu`
a list of domain name patterns that should not be cached by the httpc dns cache



### Search engine teaser

`about.headline=`
an about box in search results.
this is only shown, if the about.body is filled.

`about.body=`

`donation.iframesource=https://yacy.net/include/donate.html`

`donation.iframetarget=env/donate.html`


### Search heuristics
`heuristic.site = false`

`heuristic.searchresults = false`

`heuristic.searchresults.crawlglobal = false`

`heuristic.opensearch = false`



## Index distribution and transfer

follwing specifies if the http post body should be transfered
using content-encoding gzip during index transfer:

1. indexDistribution: which is done periodically if you have enabled 
	Index Distribution via `IndexControl_p.html`

2. indexTransfer: which can be used to transfer the whole index of a peer
	this can be started via `IndexTransfer_p.html`

3. indexControl: which can be triggered manually via `IndexControl_p.html` to
	transfer a chosen subset of the peer index     

`indexDistribution.gzipBody = true`

`indexTransfer.gzipBody = true`

`indexControl.gzipBody = true`

defining timeouts for index- transfer/distribution/control:

`indexControl.timeout = 60000`

`indexDistribution.timeout = 60000`

`indexTransfer.timeout = 120000`


defining max. allowed amount of open files during index- transfer/distribution:

`indexDistribution.maxOpenFiles = 800`

`indexTransfer.maxOpenFiles = 800`


sizes for index distribution:

`indexDistribution.minChunkSize = 10`

`indexDistribution.maxChunkSize = 1000`

`indexDistribution.startChunkSize = 200`

`indexDistribution.maxChunkFails = 1`


`index.maxReferences = 0`
limit of references per term & blob to the younges of this value.
a value of <= 0 disables this feature (no limit).
a value of e.g. 100000 can improve stability and reduce load while searching very popular
words.


## externalRedirectors

`externalRedirector=`
squid Redirector compatible


## Versions 

`Version=`
the Yacy Version this config was created with

`svnRevision=0`
old version value (keep to allow conversion of .conf, until next main releas > 1.83)



## Public
flag to show if pages shall be usable for non-admin users.

this can be applied to the Surftips.html, yacysearch.html and IndexBrowser_p.html
pages:

`publicSurftips = true`

`publicSearchpage = true`

`publicTopmenu = true`
flag to show if the top navigation bar shall be shown to all users.
If this is disabled, then the user must navigate manually from the search page
to /Status.html to get the main memu bar back.

`search.publicTopNavBar.login = true`
set to true to include a login link/status in the search page public top navigation bar


## Wiki access rights

the built-in wiki system allows by default only that the administrator is allowed to make changes
this can be changed. There are three options:

* `admin` - only the admin has write right

* `all`   - everybody has write right

* `user`  - the admin and every user registered in the user db has write right

`WikiAccess = admin`



## Local robots.txt

`httpd.robots.txt = locked,dirs,bookmarks,network,news,status,profile`
Settings for the peer's local robots.txt.

The following restrictions are possible (comma-separated):

- `all`       : entire domain is disallowed

- `blog`      : the blog-pages

- `bookmarks` : the bookmark-page

- `dirs`      : all directories in htroot (standard setting, as there is no usable information in)

- `fileshare` : all files in the peer's file share (DATA/HTDOCS/share)

- `homepage`  : all files on the peer's home page (DATA/HTDOCS/www)

- `locked`    : all servlets ending on '_p.*' (standard setting, as robots would need a password to access them anyways)

- `news`      : the news-page

- `network`   : the network-pages

- `status`    : peer's status page

- `surftips`  : the surftips-page

- `wiki`      : the wiki-page



`robots.txt.MaxActiveThreads = 200`
maximum number of robots.txt loading threads

`wikiParser.class = de.anomic.data.wikiCode`
class to use for parsing wikicode


`routing.deleteOldSeeds.permission = true`
setting for automatic deletion of old entries in passive and potential seed-db

`routing.deleteOldSeeds.time = 30`
time means max time (in days) a peer may not have been seen before it is deleted



options to remember the default search engines when using the search compare
features:

`compare_yacy.left = YaCy`

`compare_yacy.right = startpage.com`



`disk.free = 3000`
minimum free disk space for crawling (MiB)


`disk.free.hardlimit = 1000`
minimum for DHT






## ResourceObserver settings
We apply the naming of control circuit states to resources observer limit values (steady-state value, over/undershot)
under/overshot states in the system are supposed to be regulated to match the steady-state value


`resource.disk.free.autoregulate=true`
autoregulation of resource states

__ATTENTION__: be aware that using the autoregulate-option causes that the
search index data is DELETED as soon as threshold-values are reached!

the autoregulate function starts workin if resources reach over/undershot
values and the auto-regulation tries to regulate to the steadystate value



`resource.disk.used.autoregulate=false`


`resource.disk.free.min.steadystate=4096 `
 the target steady-state of minimum disk space left (MB)

`resource.disk.free.min.undershot=2048`
the undershot below the steady-state of minimum disk free as absolute size (MB)

`resource.disk.used.max.steadystate=2097152`
the target steady-state of maximum disk space for YaCy (MB)

`resource.disk.used.max.overshot=4194304`
the overshot above the steady-state of disk space for YaCy (absolute) (MB)

`memory.acceptDHTabove = 50`
minimum memory to accept dht-in (MiB)

`memory.disabledDHT = false`

`memory.standardStrategy = true`
wether using standard memory strategy - or try generation memory strategy


## Content integration settings
`content.phpbb3.urlstub = http://<mydomain>/`

`content.phpbb3.dbtype = mysql`

`content.phpbb3.dbhost = localhost`

`content.phpbb3.dbport = 3306`

`content.phpbb3.dbname = forum`

`content.phpbb3.tableprefix = phpbb_`

`content.phpbb3.dbuser = notroot`

`content.phpbb3.dbpw = joshua`

`content.phpbb3.ppf = 1000`

`content.phpbb3.dumpfile =`






## Federated index storage and federated search functionality
Federated search means that other search engines may be used together with the built-in indexing.

Each federated search may be able to be used as remote indexing service and/or as remote search service.

A typical use case for a federated search is a concurrent search from opensearch sources.

A typical use case for a remote indexing service is a remote solr index. YaCy supports remote solr indexes.

Solr indexes can be filled if enabled is set to true.

the remote index scheme is the same as produced by the SolrCell; see http://wiki.apache.org/solr/ExtractingRequestHandler

Because this default scheme is used the default example scheme can be used as solr
configuration.

To use this, do the following:

- Set `federated.service.solr.indexing.enabled = true`,

- download a Solr package from
  http://www.apache.org/dyn/closer.cgi/lucene/solr/ with a version matching
  the current major Solr version in Yacy (see 'solr.version' in the
  pom.xml),

- extract the solr package, go to the extracted directory and start solr
  (for example with `bin/solr start` or `bin/solr start -cloud`),

- create the 'collection1' and 'webgraph' collections with the appropriate
  configuration, for example with `bin/solr create -c collection1 -d
  /yacy_src_dir/defaults/solr`

- start yacy and then start a crawler. The crawler will fill both, YaCy and solr indexes.

- To check what is in solr after indexing, open http://localhost:8983/solr/


`federated.service.solr.indexing.enabled = false`

`federated.service.solr.indexing.url = http://127.0.0.1:8983/solr`

`federated.service.solr.indexing.sharding = MODULO_HOST_MD5`

`federated.service.solr.indexing.lazy = true`
the lazy attribute causes that fields containing "" or 0 are not added and not written


`federated.service.solr.indexing.timeout = 60000`

`federated.service.solr.indexing.writeEnabled = true`

`federated.service.solr.indexing.authenticated.allowSelfSigned = false`
Set to true when TLS is enabled with a self-signed certificated on a main external Solr with authentication required ( its URL looks like https://user:password@localhost:8984/solr/) 



## Temporary definition of backend services to use.

After the migration a rwi+solr combination is used, the solr contains the
content of the previously used metadata-db.

To get a handle for a migration, these values are defined as temporary, if
the migration starts the values are renamed and defined with different
default values.

The citation service is used for ranking; this is a reverse linking index. 
It should be on before and after the migration.  It can be switched off if
only a remote solr index is used.

`core.service.fulltext = true`

`core.service.rwi.tmp = true`

`core.service.citation.tmp = false`

`core.service.webgraph.tmp = false`




## Augmentation settings

`parserAugmentation = false`

`parserAugmentation.RDFa = false`




## Host browser settings

`browser.autoload = false`
Allow the administrator to stack URLs to the local crawl queue from the host browser page, automatically (when a path is unknown) or manually through a "load and index" link

`browser.load4everyone = false`
Allow everyone to stack URLs to the local crawl queue. "browser.autoload" has also to be set to true to enable automatic loading on an unknown path.



## Greedy learning

Fast information acquisition heuristic for new peers.

To make greedy learning work, it must be enabled in the network definition
the user may switch it off at any time, but if the automatic learning limit
is reached then the active flag is set to false automatically and this will
switch to that state automatically by the cleanup process each time if the
user switches it on again.  While the switch in on, it will cause that the
user-submitted search will be done along with some heuristics like: loading
linked documents and adding a twitter search.  When the learning mode is
finished, the user may switch on individual heuristics by himself.

`greedylearning.active = true`



## Postprocessing steering

`postprocessing.maximum_load = 2.5`

`postprocessing.minimum_ram = 536870912`

`postprocessing.partialUpdate = true`



## Appearance

### Interface decorations

`decoration.audio = false`

`decoration.grafics.linkstructure = true`

`decoration.hostanalysis = false`

`decoration.simpleheadernavbar = navbar-default`


### Skin
`currentSkin=pdblue`


### Colours for generic design

`color_background = #FFFFFF`
white


`color_text = #18294A`
dark blue/grey


`color_legend = #5cb85c`
success/green

`color_tableheader = #84B3DE`
brand/blue


dark/light grey (for tables):

`color_tableitem = #dddddd`

`color_tableitem2 = #eeeeee`

`color_tablebottom = #F2DEDE`
light red

`color_borderline = #888888`

`color_signbad = #990000`

`color_signgood = #009900`

`color_signother = #000099`


`color_searchheadline = #2145ca`
dark blue


`color_searchurl = #1c65ba`
green / success/3#2

`color_searchurlhover = #1c65ba`


## Debug flags

`debug.search.local.dht.off=false`
set true to disable local RWI search

`debug.search.local.solr.off=false`
set true to disable local solr search

`debug.search.remote.dht.off=false`
set true to disable remote RWI search

`debug.search.remote.dht.testlocal=false`

`debug.search.remote.solr.off=false`

`debug.search.remote.solr.testlocal=false`

`debug.snippets.statistics.enabled=false`
Set to true to enable computation of statistics on text snippets processing 
