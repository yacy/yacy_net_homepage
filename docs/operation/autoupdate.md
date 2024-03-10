# Autoupdate

## Using Autoupdate

Just go to this page: <http://localhost:8090/ConfigUpdate_p.html>

You can either manually choose a release from the update locations and
update or enable the autoupdate feature. The autoupdate regularly
(configure the interval) checks the update locations. You can choose
between main (stable snapshot-releases ~ every 2 months) or the current
dev releases. The dev releases ending on 123 are often more experimental
than the others, so they are blacklisted by default.

## Setup your own update location

An updatelocation is just a HTML-Page with links to yacy-tarballs
conforming to the version-scheme. The updatelocation is configured per
network in the network-definition (for example
defaults/yacy.network.freeworld.unit):

    network.unit.update.location0 = http://your.domain.tld/yacyreleases/

## Setup signatures

To be sure, YaCy really downloads the tarballs, the updatelocation admin
uploaded, you should provide signatures for your releases. DNS-spoofing,
man-in-in-the-middle-attacks or attacks on the webserver are not that
difficult.

### Generate a private and a public key

Configure the location where to put the private key with the property
*privateKeyFile* in *build.properties* . Then run

    ant genkey

The private key will be created at the specified location. The public
key has the extension *.pub*.


**Note:** The default value for privateKeyFile is "private.key" and the
private and public key are directly created in the yacy folder 



### Put public key in network-definition

The network definition file should look like this:

    network.unit.update.location0 = http://your.domain.tld/yacyreleases/
    network.unit.update.location0.key = MIIBuDCCASwGQeEwx7V...(very long)...bukaPtQxr2p9y1QNZFauihmu4ak4AyT

Now, YaCy will try to download the signature and check it. So provide
*.sig*-files\!



**Note:** The default network definitions file is located in
`defaults/yacy.network.freeworld.unit.`

But the values can be changed during runtime as well here: 
<http://localhost:8090/ConfigProperties_p.html>




### Generate a distribution tarball with signature

Just run:

    ant clean dist sign

You'll find the tarball and a .sig-file in the RELEASE-directory. Put
them on the updatelocation


_Converted from
<https://wiki.yacy.net/index.php?title=En:AutoUpdate>, may be outdated_




