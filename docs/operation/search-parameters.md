# Using Advanced Search Parameters

Most search requests usually contain just one word. If more than one
word is used, all words will be assumed to be part of an AND relation.
Besides searching for certain words with YaCy, you can use more advanced
methods to put a search request:

## Excluding a Word

To exclude a word from a search, a minus (`-`) can be used: for example,
if searching for *jaguar* produces too many results associated with cars
when in fact you are looking for the animal, searching for `jaguar -car`
might lead to better results.

## NEAR

`NEAR` can be used to rank results higher if search words appear in the
text close to each other. Example: `apache server NEAR`.

 It does not matter where NEAR is located in the search term.  `apache
server NEAR` and `apache NEAR server` should return the same results.

## site:

`findsomething site:yacy.net` will limit the results to the domain
yacy.net, subdomains excluded. See `tld:` operator also.

## tld:

`findsomething tld:co.uk` will limit the results to domains ending with
`*.co.uk.*` This can also be used to search on subdomains.

## inurl:

`findsomething inurl:source` will limit the results to URLs which
contain the phrase "source".

## filetype:

`findsomething filetype:pdf` will limit the results to URLs which end
with `.pdf`.

## LANGUAGE:

`findsomething LANGUAGE:en` will rank results in English language
higher. (Note: Language detection is still very experimental\!)

## RECENT

`findsomething RECENT` will rank recently crawled pages higher.

## Protocol

`findsomething /ftp` will limit the results to URLs with FTP protocol
(ftp://). List of available protocol: `/https` `/http` `/ftp` `/smb` or
`/file`

## author:

`findsomething author:busch` will limit the results to URLs with author
"busch". `findsomething author:(Wilhelm busch)` will limit the results
to URLs with author "Wilhelm busch".

## Date Search

To search for results mentioning a specific date. 

*Note: to support date search [solr index field](../dev/solr-schema.md#optional-but-recommended) `dates_in_content_dts` must be
switched on*


### on:

`findsomething on:2016/01/01` will limit the results to URLs which
contain the given date in the content.


### from: to:

`findsomething from:2016/01/01` will limit the results to URLs which
contain a date on or after the `from:` parameter. 
 
`findsomething to:2016/01/01` will limit the results to URLs which
contain a date on or before the `to:` parameter.
  
Both can be combinded to limit results to the given date range
`findsomething from:2016/01/01 to:2016/12/31`





_Converted from
<https://wiki.yacy.net/index.php?title=En:SearchParameters&oldid=22861> may
be outdated_




