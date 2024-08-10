# RWI Index distribution in YaCy

There are two indices in each YaCy instance. 

First one is horizontal - a solr/lucene index, which you use for a local instance search. 

The second one is vertical called **RWI (Reverse Word Index)** and stored in
system called _kelondro_.  In this index, urls of pages containing that
particular keyword are stored for every keyword.

RWI is distributed over whole network (e.g. default 'freeworld'), creating
the global **Distributed Hash Table (DHT)**. 

The kelondro index is used only when YaCy operates in p2p mode and it
manages the fragments that are exchanged in the p2p transmissions.  Think of
it as a “dissolvable” index: when p2p transmissions are done, fragments of
the index are taken out and transmitted to other peers.

A search in the p2p index is done on both, solr/lucene (locally) and
kelondro (locally and remote).  Searching the local kelondro index will
access those parts that have been transmitted by other peers to your own
peer.

So having two indexes (where one “dissolves” over time) ensures that you
always own our own data (what you crawled, in the solr/lucene index) while
having a distributed access to the p2p index (from what has been moved to
your peer).

## RWI

If you take a look into your log, you can see every each and now entries like:

	I 2023/11/19 15:12:01 INDEX-TRANSFER-DISPATCHER * Index transfer of 5 references for terms [ AIYDnOXpfXHp ..] and 7 URLs to peer agent-yacyname-ufe-80:Os871898Kx7Z in 0 seconds successful (21 words/s)

That means, your instance constantly go through yours RWIs, select some of
the terms, transfer them to other hosts and as they had transfered (in
several copies, usually 3), deletes them from local RWI.

When someone searches your instance remotely, the results are sent as
RWIs. They are stored bothe remotely and localy, which means, that the
popular queries are distributed across the network.

You can decide if you want to sent the RWIs and whether to receive them by
switching on and off both "Index Distribution" and "Index Receive" in 
`/ConfigNetwork_p.html`, Peer-to-Peer Mode.

Respective [config settings](yacy_conf.md#index-sharing-attributes) are:

`allowDistributeIndex=true`

`allowReceiveIndex=true`

## Storage and performance

As you crawl, pages are indexed in the solr, and at the same time, RWIs are
created. They are created even when importing the surrogates, wikis etc.

Unlike of solr index, stored in a database, RWIs are stored in files located
in `DATA/INDEX/freeworld/SEGMENTS/default/text.index.*` , managed by system
called [kelondro](https://github.com/yacy/yacy_search_server/tree/master/source/net/yacy/kelondro).

During startup and shutdown you can see a lot of entries such as:

	I 2023/11/19 16:48:57 HeapReader * wrote a dump for the 3354794 index entries of text.index.20231020165340362.blob in 531 milliseconds.
	I 2023/11/19 16:48:57 HeapReader * close HeapFile text.index.20231020165340362.blob; trace: net.yacy.kelondro.blob.HeapModifier.close(HeapModifier.java:82) -> net.yacy.kelondro.blob.ArrayStack.close(ArrayStack.java:906) -> net.yacy.kelondro.rwi.ReferenceContainerArray.close(ReferenceContainerArray.java:79) -> net.yacy.kelondro.rwi.IndexCell.close(IndexCell.java:606) -> net.yacy.search.index.Segment.close(Segment.java:508) -> net.yacy.search.Switchboard.close(Switchboard.java:2012) -> net.yacy.yacy.startup(yacy.java:404) -> net.yacy.yacy.main(yacy.java:832)
	I 2023/11/19 16:48:57 HeapReader * wrote a dump for the 5176 gap entries of text.index.20231020212118698.blob in 1 milliseconds

meaning that parts of the index (segments) are merged, compressed etc.  This
can be time consuming and prolonging the restart.  The more RWIs, the more
work to do. After a crash, rewriting the indices can take even hunderds
minutes, upon next start-up.

They also occupy certain ammount of RAM, which you can inspect in
`/PerformanceMemory_p.html` at the end of "Object Index Caches" table (e.g. 
Total Mem: 4,980.06 MB).

Merging the segments is done also in background, in a similar fashion as
lucene does that.  Two files are merged into one new.  There is a threshold
when this has to be done..  If you crawl a lot, after pausing the crawl, you
still observe a lot of IO and you can see the "teeth" in the Performance
memory graph, as backend is merging the segments, until it stays still and
the RAM curve is not rising anymore.  Everything is clean and tidy now.

After deleting a local RWI database (either in _"Index Administration >
Cleanup > Delete RWI Index"_ or just deleting the `text.index.*` files while
your YaCy is stopped), you can observe quite a drop in RAM consumption
and increase of speed of startup, shutdown and search.  Some people prefer
to delete the RWIs regulary from that reason, but on the other hand, their
presence is the basic of distributed P2P search.

Sometimes the RWIs even fill out all the RAM allocated for YaCy, resulting
in frequent GC (a Java process of cleaning the memory, performance expenssive)
and, later on, even in filling the RAM in a way that instance would break. The
cure is easy then: just delete the RWI files and start YaCy again.

The question is, if RWIs are implemented efficiently and whether they couldn't be
implemented in a way, that doesn't degrade the performance of local peer in
such huge degree.


## RWI transport

There are 3 ways of RWI transport to another host: 

1. **indexDistribution**: which is done periodically if you have enabled 
        Index Distribution via `/IndexControl_p.html`

2. **indexTransfer**: which can be used to transfer the whole index of a peer
        this can be started via `/IndexTransfer_p.html`

3. **indexControl**: which can be triggered manually via
	`/IndexControl_p.html` to
        transfer a chosen subset of the peer index


In regular RWI distribution, RWIs are selected from the files, chunked,
sent to randomly selected hosts and deleted from local index. 

The entries for transfer are selected by DHT targets.  Age is not relevant. 
The DHT target (another peer) is selected randomly and then index entries
are selected for transfer.  The rule is, that exactly those index entries
are selected for transfer which I would expect to be at the peer when I
search using the same DHT rule.


You can see the number of yours RWI both in _Crawler Monitor (RWIs - P2P
Chunks)_ and _Peer-to-Peer Network_ (/Network.html).  There, you can also watch
yours inbound and outbound transfers as green or red lines, respectively.


## Tuning the transport

If you are not satisfied with huge amount of yours RWIs, you can tune some
of the config file settings to sent them away more swiftly:

`20_dhtdistribution_idlesleep=30000`
the time waiting before next chunk is transfered. lowering means
transfering chunks more frequently

`20_dhtdistribution_busysleep=15000`
**???? not sure with this**

`20_dhtdistribution_memprereq=12582912`
don't do the distribution when RAM is lower than this number

`20_dhtdistribution_loadprereq=2.0`
don't do the distribution when load is lower than this number.  increase to
do the distribution despite the higher load

The sizes of chunks can be changed in the following [settings](yacy_conf.md#index-distribution-and-transfer):

`indexDistribution.minChunkSize = 10`

`indexDistribution.maxChunkSize = 1000`

`indexDistribution.startChunkSize = 200`

_(Not sure, if they actually work. Even when setting minChunkSize to
larger value, chunks with just a few URLs are still sent.)_

Furthermore in network definition, there is a definition of "redundancy",
which means, how many identical copies of your RWI are sent to other hosts,
before they are deleted localy.

`network.unit.dhtredundancy.senior=3`

`network.unit.dhtredundancy.junor=1`

Above default setting means that 3 copies of every RWI is sent to other
host (before they're deleted localy) when you're senior peer, and just one
when you're junior.  

`network.unit.dht.partitionExponent=4`
is described in details [in a paper](https://yacy.net/material/Description_of_the_YaCy_Distributed_Web_Search_Engine_Herrmann_Ning_Diaz_Preneel_ESAT_KULeuven_COSIC_article-2459.pdf).


## Search

If you don't use p2p network to receive the results, you can disable local
search in RWIs and speed-up the search by switching it off in "Search data
sources" in _System Administration > Debug/Analysis Settings_.


## Technical details

In detail, source codes describe the transfer process in 
[Dispatcher.java](https://github.com/yacy/yacy_search_server/blob/master/source/net/yacy/peers/Dispatcher.java) as:

The `dispatcher` class accumulates `indexContainerCache` objects before they are transfered
to other peers. A dispatcher holds several of such caches to enhance the transmission process.

Before a RWI is sent, the following process is applied:

1.    A number of RWIs are selected and accumulated.
      When they are selected, they are removed from the index,

2.    the RWI collection is split into a number of partitions according to the vertical DHT,

3.    the split RWIs are enqueued as `Entry object` in the write buffer of the dispatcher,

4.    more entries may be enqueued to the dispatcher and entries with the same
      primary target are accumulated to the same buffer entry,

5.    the largest entries are selected from the dispatcher write buffer and enqueued to the 'next' array
      which means that they are ready for transmission,

6.    the dispatcher takes some of the entries in the next queue and initiates
      transmission to other peers concurrently.  As much transmissions are
      initiated concurrently as the redundancy factor,

7.    a transmission thread executes the entry transmission,

8.    the transmission thread initiates another transmission in case that it fails,

9.    when the wanted number of redundant peers have received the entries,
      they are removed from the next queue.



