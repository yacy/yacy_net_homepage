# Definition of Ranking Rules

[Ranking](http://en.wikipedia.org/wiki/Ranking) is the technical instance of
[relevance](https://en.wikipedia.org/wiki/Relevance), which is 'what the
user thinks is important'.  Since almost every user has a different opinion
about such 'relevance' it should be possible to define a personal ranking
for a personal relevance.  Also in different search environments the ranking
should change, i.e.  within a site-only search the user expects more
in-depth results in contrast to popular documents in unlimited internet
search.

A ranking can be done by the application of coefficients to document
attributes.  Such attributes can be various counts, like a count of words,
bytes, outbound links, inbound links (from same or other domains) and so on. 
There is a large number of such attributes in YaCy.  To see them all, open
localhost:8090/IndexControlURLs_p.html in your YaCy peer.  The ranking is
done using Solr ranking methods.  If your peer does a remote search, then
also your own ranking configuration is applied to the remote peer.  The
configuration interface for this is in
http://localhost:8090/RankingSolr_p.html

For a distributed search in YaCy there is a special challenge: some results
from other peers may be returned without this rich set of attributes.  They
return a so-called Reverse Word Index References containing a small set of
attributes.  To combine search results from other peers, they must be ranked
using this subset of attributes.  We call that process 'post-ranking'.  The
configuration interface for this is in
http://localhost:8090/RankingRWI_p.html.  If you use YaCy for a portal
search or intranet search without p2p mode, then you don't need to care
about it.


## Solr Ranking in /RankingSolr_p.html

You can setup the ranking rules for the search in _Search Portal Integration > 
Ranking and Heuristics_.

There are three sections:

* 'Default profile' is used for basic search (_Solr Ranking Configuration >
Select a profile > Default Profile_)

* 'Date profile' is special settings for '/date' searches, searches sorted
  by date _(Solr Ranking Configuration > Select a profile > Date Profile)_,

* 'RWI Ranking' is used for RWI searches.

The default ranking in Solr is done using 'boosts' on search fields.  You
can define which fields in the index Schema can be searched when you submit
a search and how strong they are boosted on every field using the "Solr
Boosts" section within /RankingSolr_p.html.  If you would like to have
search results, which have matches with your search word in a specific field
higher, then increase the boost value for that specific field.  Each field
will produce a ranking value and the resulting ranking score will be the sum
of these boosted fields multiplied with a norming factor which is the
inverse of the square root of the sum of squared weights.

The boosted field ranking is just a formula for the relevancy of the search
hit regarding the text content and construction of the document, but not for
the topology of the document within the searched document set.  To influence
the ranking your can use Boost Queries and Boost Functions.

You can assess & debug the ranking points for searches by setting
`search.result.show.ranking = true` in [yacy.conf](./yacy_conf.md) 
or by setting _Administration > System Administration > Debug/Analysis
Settings > Ranking information > Show search results scores_ in the UI. 
Then the score will be visible in the search results.

### Boost Function

A Boost Function is a formula which evaluates attributes which are not
search fields.  You can use this i.e.  to evaluate the date fields (for a
date ordering) or to move documents with a lower clickdepth to the front. 
Example formulars are:

`recip(ms(NOW,last_modified),3.16e-11,1,1)`

to sort by last_modified and bring the most current documents to the top,

`div(add(references_internal_i,product(references_external_i,references_exthosts_i)),add(clickdepth_i,1))`

to consider documents with many external references as more important but
also count the clickdepth.  


Just try to do your own experiments using the attributes from the index
schema.


### Boost Query

A Boost Query is a query that is attached to the other queries that YaCy
calculates from the boost field configuration.  It can be considered as a
default, fixed add-on to a search.  The purpose is, to boost specific
attributes within the index schema.  By default, we set this to:

`fuzzy_signature_unique_b:true^100000.0`

which boost a field which assignes that a document is unique.  This moves
double content to the back.  You can use this like a default filter for your
documents which move forward or backward in the result list independently
from the searched word.


If you want, for example, to prefer documents from a particular TLD (_.au_
in this example), use boost query:

`host_s = query => *.au^50`

To understand the solr queries, see [Solr Query
Guide](https://solr.apache.org/guide/solr/latest/query-guide/query-syntax-and-parsers.html)
or a [simple tutorial](https://solrtutorial.com/solr-query-syntax.html).

### Filter Query

This is not actually a ranking mechanism, but certain use cases require that
search results shall be 'boosted' to the end of the search result list (i.e. 
by boosting the reverse to the front) or should be removed completely from
the results.  To do so, a filter query can be assigned in this field to
filter out unwanted results.  The content of the field is a search term
which must match with all wanted results.  An example is the removal of all
'double' documents as flagged with the attributes http_unique_b and/or
www_unique_b.  If you do not want http documents if the same url with https
is present and if you want to remove all documents without leading 'www.' if
one with 'www.' is present, enter the following term:

`http_unique_b=true AND www_unique_b=true`

It is also possible to remove all documents with special words in the text
part, i.e.  if you want to remove all documents containing the word 'foo',
use the following term:

`-text_t:foo`


### Solr Boosts

In this section of Ranking config you can find a list of all searchable text
fields.  Only such fields are actually used in a document search which are
filled with a boost > 0 (empty boost fields mean boost = 0).  The higher the
boost value, the more relevant is the search field.


