# System Requirements

To get YaCy running, the only thing you need is a somewhat recent
computer (everything that used to be up-to-date in this millennium
should be all right) and an operating system that supports Java. Apart
from this, you should allow for 25GB (or at least 1-2 GB for a start) of
disk space on your hard-drive for collected data on websites and the
index itself (keep in mind in which directory YaCy stocks its data, e.g.
in /var/lib for Debian GNU/Linux). The more [physical
memory](http://en.wikipedia.org/wiki/Random_access_memory) (RAM) you
have the better, but 256MB are a good start. Less is also acceptable,
but it will make work a bit slow.

YaCy has been written in the
[Java](http://en.wikipedia.org/wiki/Java_\(programming_language\))
programming language, which means that it is available for a great
number of computer systems, as Java is available for almost all systems
in use. An outstanding feature of Java programs is the fact that they
can be run on different systems without any modification.

Java can be downloaded and used for free. If there is no Java
environment on your system yet, you must install it before installing
YaCy. GNU/Linux distributions may include, e.g. a free one called
[OpenJDK](http://openjdk.java.net/install/). Otherwise, Java is
available from the [Sun website](http://java.com/en/download/index.jsp).
The minimum Java version you need for YaCy is Java 11 — which might
change in the future.

Note that Apache Solr beeing a YaCy core component, it is a good idea to
follow also Solr recommendations. For example, YaCy 1.82 includes Solr
4.10.3 : Java 1.7.0_u55 or later is recommended (see [Solr System
Requirements](https://lucene.apache.org/solr/4_10_3/SYSTEM_REQUIREMENTS.html))

Because of this — and the fact that the newer Java version is more
powerful than the old one — you should chose Java 11 right from the
start. If the only thing you want to do is just run Java programs you
can make do with the [JRE (Java Runtime
Environment)](https://en.wikipedia.org/wiki/Java_Runtime_Environment). If you want to develop
Java programs or even help making YaCy better, you will need the [JDK
Java Development Kit](http://en.wikipedia.org/wiki/JDK).



_Converted from <https://wiki.yacy.net/index.php?title=En:Requirements>, may
be outdated_




