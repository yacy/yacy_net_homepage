# Install YaCy-packages from OpenSUSE Build Service

## openSUSE

steps on commandline:

    zypper addrepo http://download.opensuse.org/repositories/home://f1ori/openSUSE_11.0_contrib/home:f1ori.repo
    zypper install yacy

You can do the same steps with yast and yast2.

## Fedora

steps on commandline:

    wget http://download.opensuse.org/repositories/home://f1ori/Fedora_9/home:f1ori.repo -O /etc/yum.repos.d/home:f1ori.repo
    yum install yacy

## Mandriva

Unfortuately, the default package manager of Mandriva doesn't support
the repository-format "repomd" That's why you have to install another
packagemanager like smart.

With smart, you can added the repo and install yacy like that:

    smart channel --add http://download.opensuse.org/repositories/home://f1ori/
    smart update
    smart install yacy



_Converted from
<https://wiki.yacy.net/index.php?title=En:OBSInstall>, may be outdated_




