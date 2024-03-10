# Performance Tuning


**YaCys crawling and indexing performance can be dramatically
enhanced.** The default settings in a standard YaCy release are not
preset for maximum performance, because the software shall run on
personal computers that are mainly used for other purposes. Too high
performance settings would eat up all CPU time, memory and IO bandwidth.
But YaCy can be specialized for a high-performance web-search production
system.

Depending on your computing environment, you can use one or all of the
following remommendations to modify YaCy. Please be aware that all
changes can also have some unwanted side-effects.

  

## Increase Memory Usage

This means that upon start-up time YaCy takes more memory from the OS.

#### How-To

Open the Performance Page, select the 'Memory Settings for Database
Caches' Submenu. Under 'Memory Settings' increase 'Maximum used memory';
click 'Set'. Then re-start YaCy

#### Effect

This is a premise for the following performance settings. It also can
speed up YaCy if memory is low and there are frequent Garbage
Collections

#### Side-Effects

You decrease the available memory for other applications on your system.

#### Why is this not done by default?

YaCy wants to be nice to the average computer user and their systems.
Modern computers have 512MB RAM or more. We believe that 96MB for YaCy
as default is a good tradeoff between performance and resource
allocation.

  

## Increase Indexing Cache

Indexing is the process of creation a Reverse Word Index (RWI)
datastructure from a given set of text documents. It means that a
document-words releation is reversed to a word-documents relation. This
can be enhanced using a word-documents relation write cache. There are
currently two write caches of that kind: one for RWIs that are supposed
to be transmitted to other peers (DHT-Out) and one for RWIs that shall
be stored on the own peer (DHT-In). But unfortunately the DHT-Out cache
fills up faster than it is possible to send them away to other peers, so
they are (temporary) stored to the own RWI index file(s). Flushing to
the file is IO-expensive, and the greater the cache the less IO-events
happen.

#### How-To

Open the Performance Page. Within the 'Cache Settings' table, you can
see some input fields. The 'Maximum number of words in cache' value can
be increased (i.e. 90000 if you have assigned 1GB RAM in the previous
step). You can do this for DHT-Out and DHT-In. Normally more words are
stored in DHT-Out, because only a fraction of the words that you index
are stored on your own peer. Be aware that this value is decreased
automatically if a low-memory event occurs, so that words are flushed an
memory is freed again. This value is then automatically re-set to
'Initial space of words in cache', so please increase this value also.
The next two values 'word flush divisor' are used to determine how many
words shall be flushed to disc after each document is indexed. There are
two values, one for busy-cycles and one for idle-cycles. That means you
can decide that the cache is flushed faster if the peer is busy. I.e.:
if you set the busy divisor to 10000, then 5 words are flushed after
index a page when your word cache has 50000 words in it.

#### Effect

Indexing time decreases, PPM (page-per-minute) increases.

#### Side-Effect

This needs a lot of memory. If you set too high values, this may cause
frequent Garbage Collections (GC) and that may slow down overall speed
dramatically. If you increase cache space, frequently visit the
performance page and check if the complete memory is taken (at 'Memory
Settings for Database Caches')

#### Why is this not done by default?

It needs higher memory assignment by default. Please see 'Increase
Memory Usage' above.

  

## Decrease Waiting Time Between Scheduled Tasks

YaCy has a thread organisation for the processing of queues. Each queue
containes entries for special tasks, i.e. there is a queue with urls
that wait for beeing fetched, there is a queue with documents that wait
to be indexed and so on. Between each job of every task there is a pause
to give other processes on the owners computer more CPU and IO time.
This must be done with pauses in YaCy, because most OS' do only handle
CPU priority and time-slicing, but not IO-usage balancing between
processes.

#### How-To

Open the Performance Page. At the 'Scheduled tasks overview and waiting
time settings' you can see some input fields for delay values. See at
the 'Delay between busy loops' column: There are the delay values in
milliseconds that are used to pause between every queue processing.

  - if you want to speed up crawling, decrease the 'Local Crawl' value.
    **PLEASE** do not set this to zero, because that may cause cause too
    heavy load on the target HTTP server.
  - if you want to speed up indexing, decrease the 'Parsing/Indexing'
    value.

#### Effect

Queues are worked-off faster. If the delay values are well-balanced,
then this may cause better indexing speed.

#### Side-Effect

If you do too fast page-fetching, this may cause denial-of-service
effects on target web servers. There is a built-in load-balancing beween
target domains, but that may not help if you are crawling only a single
domain. Please try to avoid this case. For all other values: no pauses
between loops may cause that your system may not be used for other tasks
than YaCy, because then YaCy eats up all IO-bandwith and CPU time.

#### Why is this not done by default?

To protect the used from doing DoS-by-mistake and to implement a
'IO-nice' so that the users computer is not blocked.

  

## Switch to Robinson Mode

If you want to use the indexing result only on your own private search
portal, you can switch off index ditribution, index receive and remote
indexing. We call that the Robinson mode. Because index distribution is
synchronized with indexing tasks, the indexing is slower when index
distribution is switched on. There is no circumvention of
synchronization by implementation of a separate DHT transmission thread,
because both processes would access the same databases at the same time
and conflicting IO would cause less performance.

#### How-To

Open the 'Basic Configuration' Page and click on the 'Network' sub-menu.
Check the 'Robinson Mode' button. You can then select which kind of
robinson mode you want to activate: - if you want complete separation
and invisibility to other peers, choose 'Private Peer' - if you want
content-separation, but visibility to other peers (they are allowed to
search your peer), choose 'Public Peer' - if you want a cluster of
public peers, choose 'Public Cluster'. You can define the cluster by
simply naming the other cluster peers in a comma-separated list. The
Form of the names are <peer-name\>.yacy

#### Effect

Because DHT transmissions are synchronized with the indexing within the
'Parsing/Indexing' queue (see above), indexing ist speed up if there is
no DHT transmission. Furthermore, your web index is not mixed with
indexes from other peers.

#### Side-Effect

When index distribution or index receive is switched off (or both), then
YaCy does not permit a global search. If a web search is startet, only
indexes from the own peer are used. This functional limitation was set
to ensure that the peer-to-peer principle of give-and-take is preserved.
In other words: if you switch to Robinson Mode you can use YaCy only as
your own indexing/search portal.

#### Why is this not done by default?

Without index distribution there would not be a global search engine.

## Increase Number of Crawl Threads

If your web-crawl is well-balanced (many domains) and crawling is still
too slow (indexing queue is empty and cannot be filled fast enough by
the crawler), then it is recommended to increase the maximum number of
active crawl threads.

#### How-To

Open the Performance Page. At the 'Thread Pool Settings' table you see
input fields for maximum active crawl threads. Increase this number, but
limit it to a number that is not too big for your (cheap) router.

#### Effect

The number of concurrent http-fetch requests to target web servers
increase. This can speed up crawling.

#### Side-Effect

Your router may not be able to handle so many concurrent requests.

#### Why is this not done by default?

To be compliant with minimum requirements of cheap network equipment,
and to protect target servers from beeing accessed with too many
requests at the same time.

  

## Do Not Monitor the Crawler

After a web indexing is started, you see the Crawler Monitor page. This
page uses Ajax technology to load several xml files from the built-in
web server, which are constructed doing database-lookups. This creates a
constant IO usage which conflicts with the IO needs during crawling

#### How-To

After you started a crawl, do not leave the Crawler Monitor page open.
You can monitor the PPM number also at the Status page and at the
Network page.

#### Effect

No additional IO is created that conflics with indexing. Indexing gets
faster.

#### Side-Effect

You cannot see the Crawling Monitor page.

#### But why is there this feature if it decreases speed?

That would mean that we should not have something like the Crawler
Monitor page. But thats such a strong nice-to-have (as heard many times)
that we recently implemented that.

## Switch Off File Sharing

Other application that create strong IO or IP load causes YaCy to work
more slowly. File sharing software create both, strong IO and IP load.
There is no need to shut down file sharing, but it will increase speed
of YaCy

## Re-Boot your Router

Cheap routers cannot handle many open network connections very proper.
In case that network connections get lost, they may even turn into
zombie threads. When doing a web crawl it typically occurrs that many
unresolved links are tried to access, which may cause this problem. If
your internet connection gets constantly slower, then the most probable
cause is not heavy load from YaCy, but too many zombie thread in your
router. A re-boot of the router solves that problem and increases
internet speed again.

## Start Several Crawls

It may appear strange, but starting of several crawl jobs can increase
crawling speed because that may help to balance the http-fetch over
different domains. If the servers at the different domains are slow,
then many jobs will cause a balancing over these domains which can
increase crawling speed.

## Move DATA to a RAID

This was never tested, but storage of the RWI on a RAID can speed up
indexing because indexing is such a heavy IO job.

## Put Parts of the Index to Other Disc

This would be a nice alternative to the RAID idea: set symbolic links
for paths of the index storage to another IO device. Doing so, you
divide the IO over several devices which can give more overall IO speed.
A path that is appropriate for separation to another disc could be
DATA/INDEX/*foo*/SEGMENTS/*bar*/, this is the directory where the RWIs
are stored, *foo* and *bar* are freeworld/default for default settings.

## What the heck is going on?

Now, the following isn't even remotely relevant to YaCy, and yet it is.
The `sysstat` tools are a neat package of utils available for variants
of the [GNU Operating System](http://www.gnu.org/) such as
[Linux](http://www.kernel.org/).

Running the following...:

    while true; do  clear; tail -n 26 DATA/LOG/yacy00.log;   vmstat; iostat; sleep 20s; done

or just

    tail -f DATA/LOG/yacy00.log

*(just press ctrl-c when you feel overwhelmed by the immensity of this
information)*

..may give you information which could be used to make good decisions as
to what the effects of your adjustments to YaCy settings are on your
system.

You prefer to just tail the log in one
*[screen](https://www.gnu.org/software/screen/manual/html_node/index.html)* window and run `iostat
10` or `wmstat 10` in another (the parameter is the delay beween
updates, but make no mistake: These tools have many more useful
options).

### vmstat

**IO** (In/Out) is data being read and written to the disk. The rest of
the system has to wait for this, so the system will seem utterly slow
when there is very high IO activity.

**Swap** are bytes swapped written to and from your swap. If you have
such IO activity then you should *reduce* the amount of memory made
available to YaCy: There are too much in the memory and it's been
swapped out - and this is very bad. *cache* is disk cache and in reality
free memory; it's dropped once the memory is neede by a program.

IO shows you blocks in and blocks out. High numbers is very sad and
depressing: It means that there is a huge amount of disk activity.

The CPU field shows you (us)er processes, (sy)stem processes, (id)le
activity and your worst nightmare: (wa)iting for IO. An example of this
is:

    procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
     r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
     0  0  24600   3584   4624 383804    0    1   203   185    6     4  8  2 75 15
     0  0  24600   7284   4576 380064    0    0   625    60 2016   297 11  9 68 12
     0  1  24600   2472   4636 384516    0    0   749    49 1976   300  5  2 79 14
     0  1  24600   4072   4656 382756    0    0  1365   730 2048   347  6  1 65 28
     0  1  24600   2716   4672 384032    0    0  1373   398 2105   301 29 19 38 15
     0  1  24600   3712   4652 382844    0    0  1223    74 2085   325 15 16 60  9
     0  0  24600   4076   4600 383520    0    0  1959   639 2058   353  5  2 53 41

This system appears to be doing fine, since it's not (wa)iting that much
for IO.

In contrast: The following box..:

    procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
     r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
     0  2  59104   2404   2528 143560    0    0  1247   110 2593   493 28  2  9 61
     0  0  59104   2292   2380 143520    0    0  1393    33 2679   442  9  8  5 77
     0  1  59104   1160   2180 145600    0    0  1403     3 2689   380  6  6 16 73
     0  2  59104   1380   2092 145716    0    0  1601   140 2503   431  4  2  6 87
     0  3  59100   1032   1892 145864   30    0  1580   179 2748   489 19  4  7 69
     0  2  59100   1996   1760 145136    0    0  1485    59 2770   447 12  2  0 86
     0  2  59100   2200   1768 144840    0    0  1124    10 2663   466  3  2 16 78

...is mostly (wa)iting for bytes being read (and occationally written)
from the storage device. There are almost no CPU cycles since it's all
busy (wa)iting for bytes to be read. This is very bad and means that you
may want to take configuration steps in order to reduce IO activity.





_Converted from
<https://wiki.yacy.net/index.php?title=En:Performance>, may be outdated_




