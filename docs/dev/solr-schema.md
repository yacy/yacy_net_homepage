# Solr Schema of YaCy

YaCy stores the information about crawled webpages and the links between them in solr databases:
`collection1` for page indexing and `webgraph` for links structure indexing.


Schema of `collection1` is defined in [defaults/solr.collection.schema](https://github.com/yacy/yacy_search_server/blob/master/defaults/solr.collection.schema)
and [source/net/yacy/search/schema/CollectionSchema.java](https://github.com/yacy/yacy_search_server/blob/master/source/net/yacy/search/schema/CollectionSchema.java)

and can be modified in _Index Administration > Solr Schema Editor_.


The names of fields are usually suffixed `_dt` if containing date, `_dts` for multiple
dates, `_i` for integer number, `_l` for long number, `_b` for boolean
(true/false), `_s` for string, `_txt` for text, and `_sxt` for ???, `_p` for
geo-coordinates.

The fields are:

## mandatory

**`id`** _(string)_ - primary key of document, the URL hash **mandatory field**

**`sku`** _(string)_ - url of document - a 'sku' is a stock-keeping unit, a unique identifier and a default field in unmodified solr.

**`last_modified`** _(date)_ - last-modified from http header - date document was last modified, needed for media search and /date operator

**`load_date_dt`** _(date)_ - time when resource was loaded

**`content_type`** _(string)_ - mime-type of document

**`title`** _(text_general)_ - content of title tag

**`host_id_s`** _(string)_ - id of the host, a 6-byte hash that is part of the document id - String hosthash();

**`host_s`** _(string)_ - host of the url

**`size_i`** _(integer)_ - the size of the raw source - int size();

**`failreason_s`** _(string)_ - fail reason if a page was not loaded. if the page was loaded then this field is empty

**`failtype_s`** _(string)_ - fail type if a page was not loaded. This field is either empty, 'excl' or 'fail'

**`httpstatus_i`** _(num_integer)_ - html status return code (i.e. "200" for ok), -1 if not loaded"

**`url_file_ext_s`** _(string)_ - the file name extension 

**`host_organization_s`** _(string)_ - either the second level domain or, if a ccSLD is used, the third level domain - needed to search in the url

**`inboundlinks_urlstub_sxt`** _(string)_ - internal links, the url only without the protocol - needed for IndexBrowser

**`inboundlinks_protocol_sxt`** _(string)_ - internal links, only the protocol - for correct assembly of inboundlinks
inboundlinks_protocol_sxt + inboundlinks_urlstub_sxt is needed

**`outboundlinks_protocol_sxt`** _(string)_ - external links, only the protocol - for correct assembly of outboundlinks
outboundlinks_protocol_sxt + outboundlinks_urlstub_sxt is needed

**`outboundlinks_urlstub_sxt`** _(string)_ - external links, the url only without the protocol - needed to enhance the crawler

**`images_urlstub_sxt`** _(string)_ - all image links without the protocol and '://'

**`images_protocol_sxt`** _(string)_ - all image link protocols - for correct assembly of image url  images_protocol_sxt + images_urlstub_sxt is needed


## optional but recommended, part of index distribution
 
**`fresh_date_dt`** _(date)_ - date until resource shall be considered as fresh

**`referrer_id_s`** _(string)_ - id of the referrer to this document, discovered during crawling - byte[] referrerHash();

**`publisher_t`** _(text_general)_ - the name of the publisher of the document - String dc_publisher();

**`language_s`** _(string)_ - the language used in the document - byte[] language();

**`audiolinkscount_i`** _(num_integer)_ - number of links to audio resources - int laudio();

**`videolinkscount_i`** _(num_integer)_ - number of links to video resources - int lvideo();

**`applinkscount_i`** _(num_integer)_ - number of links to application resources - int lapp();


## optional but recommended

**`title_exact_signature_l`** _(num_long)_ - the 64 bit hash of the `org.apache.solr.update.processor.Lookup3Signature` of title, used to compute `title_unique_b`

**`title_unique_b`** _(bool)_ - flag shows if title is unique within all indexable documents of the same host with status code 200; if yes and another document appears with same title, the unique-flag is set to false

**`exact_signature_copycount_i`** _(num_integer)_ - counter for the number of documents which are not unique (== count of not-unique-flagged documents + 1)

**`fuzzy_signature_text_t`** _(text_general)_ - intermediate data produced in `EnhancedTextProfileSignature`: a list of word frequencies 

**`fuzzy_signature_copycount_i`** _(num_integer)_ - counter for the number of documents which are not unique (== count of not-unique-flagged documents + 1)

**`process_sxt`** _(string)_ - needed (post-)processing steps on this metadata set

**`dates_in_content_dts`** _(date)_ - if date expressions can be found in the content, these dates are listed here as date objects in order of the appearances

**`dates_in_content_count_i`** _(num_integer)_ - the number of entries in `dates_in_content_sxt`

**`startDates_dts`** _(date)_ - content of itemprop attributes with `content='startDate'`

**`endDates_dts`** _(date)_ - content of itemprop attributes with `content='endDate'`

**`references_i`** _(num_integer)_ - number of unique http references, should be equal to `references_internal_i + references_external_i`

**`references_internal_i`** _(num_integer)_ - number of unique http references from same host to referenced url

**`references_external_i`** _(num_integer)_ - number of unique http references from external hosts

**`references_exthosts_i`** _(num_integer)_ - number of external hosts which provide http references

**`crawldepth_i`** _(num_integer)_ - crawl depth of web page according to the number of steps that the crawler did to get to this document; if the crawl was started at a root document, then this is equal to the clickdepth

**`harvestkey_s`** _(string)_ - key from a harvest process (i.e. the crawl profile hash key) which is needed for near-realtime postprocessing. This shall be deleted as soon as postprocessing has been terminated.

**`http_unique_b`** _(bool)_ - unique-field which is true when an url appears the first time. If the same url which was http then appears as https (or vice versa) then the field is false

**`www_unique_b`** _(bool)_ - unique-field which is true when an url appears the first time. If the same url within the subdomain www then appears without that subdomain (or vice versa) then the field is false

**`exact_signature_l`** _(num_long)_ - the 64 bit hash of the `org.apache.solr.update.processor.Lookup3Signature` of `text_t`

**`exact_signature_unique_b`** _(bool)_ - flag shows if exact_signature_l is unique at the time of document creation, used for double-check during search

**`fuzzy_signature_l`** _(num_long)_ - 64 bit of the `Lookup3Signature` from `EnhancedTextProfileSignature` of `text_t`

**`fuzzy_signature_unique_b`** _(bool)_ - flag shows if `fuzzy_signature_l` is unique at the time of document creation, used for double-check during search

**`coordinate_p`** _(location)_ - point in degrees of latitude,longitude as declared in WSG84 

**`coordinate_p_0_coordinate`** _(coordinate)_ - automatically created subfield, (latitude)

**`coordinate_p_1_coordinate`** _(coordinate)_ - automatically created subfield, (longitude)

**`ip_s`** _(string)_ - ip of host of url (after DNS lookup)

**`author`** _(text_general)_ - content of author-tag

**`author_sxt`** _(string)_ - content of author-tag as copy-field from author. This is used for facet generation

**`description_txt`** _(text_general)_ - content of description-tag(s)

**`description_exact_signature_l`** _(num_long)_ - the 64 bit hash of the `org.apache.solr.update.processor.Lookup3Signature`
of description, used to compute `description_unique_b`

**`description_unique_b`** _(bool)_ - flag shows if description is unique within all indexable documents of the same host with status code 200; if yes and another document appears with same description, the unique-flag is set to false

**`keywords`** _(text_general)_ - content of keywords tag; words are separated by comma, semicolon or space

**`charset_s`** _(string)_ - character encoding

**`wordcount_i`** _(num_integer)_ - number of words in visible area

**`linkscount_i`** _(num_integer)_ - number of all outgoing links; including `linksnofollowcount_i`

**`linksnofollowcount_i`** _(num_integer)_ - number of all outgoing inks with nofollow tag

**`inboundlinkscount_i`** _(num_integer)_ - number of outgoing inbound (to same domain) links; including `inboundlinksnofollowcount_i`

**`inboundlinksnofollowcount_i`** _(num_integer)_ - number of outgoing inbound (to same domain) links with `nofollow` tag

**`outboundlinkscount_i`** _(num_integer)_ - number of outgoing outbound (to other domain) links, including `outboundlinksnofollowcount_i`

**`outboundlinksnofollowcount_i`** _(num_integer)_ - number of outgoing outbound (to other domain) links with nofollow tag

**`imagescount_i`** _(num_integer)_ - number of images

**`responsetime_i`** _(num_integer)_ - response time of target server in milliseconds

**`text_t`** _(text_general)_ - all visible text

**`synonyms_sxt`** _(string)_ - additional synonyms to the words in the text

**`h1_txt`** _(text_general)_ - h1 header

**`h2_txt`** _(text_general)_ - h2 header

**`h3_txt`** _(text_general)_ - h3 header

**`h4_txt`** _(text_general)_ -h4 header

**`h5_txt`** _(text_general)_ - h5 header

**`h6_txt`** _(text_general)_ - h6 header


## unused, delete candidates
**`md5_s`** _(string)_ - the md5 of the raw source - String md5() - Deprecated

**`httpstatus_redirect_s`** _(string)_ - redirect url if the error code is `299 < httpstatus_i < 310` - TODO: delete candidate, not used so far (2014-12-26)


## optional values, not part of standard YaCy handling 
(but useful for external applications)

**`collection_sxt`** _(string)_ - tags that are attached to crawls/index generation to separate the search result into user-defined subsets called
_collections_

**`csscount_i`** _(num_integer)_ - number of entries in css_tag_txt and css_url_txt

**`css_tag_sxt`** _(string)_ - full css tag with normalized url

**`css_url_sxt`** _(string)_ - normalized urls within a css tag

**`scripts_sxt`** _(string)_ - normalized urls within a scripts tag

**`scriptscount_i`** _(num_integer)_ - number of entries in scripts_sxt

**`robots_i`** _(num_integer)_ - content of `<meta name="robots"
content=\#content\#\>` - tag and the "X-Robots-Tag" HTTP property

is encoded as binary value into an integer:

| bit   | value |
| ----- | ------  |
| bit  0 | "all" contained in html header meta     |
| bit  1 | "index" contained in html header meta   |
| bit  2 |  "follow" contained in html header meta |
| bit  3 | "noindex" contained in html header meta |
| bit  4 | "nofollow" contained in html header meta |
| bit  5 | "noarchive" contained in html header meta | 
| bit  8 | "all" contained in http header X-Robots-Tag |
| bit  9 | "noindex" contained in http header X-Robots-Tag |
| bit 10 | "nofollow" contained in http header X-Robots-Tag |
| bit 11 | "noarchive" contained in http header X-Robots-Tag |
| bit 12 | "nosnippet" contained in http header X-Robots-Tag |
| bit 13 | "noodp" contained in http header X-Robots-Tag |
| bit 14 | "notranslate" contained in http header X-Robots-Tag |
| bit 15 | "noimageindex" contained in http header X-Robots-Tag |
| bit 16 | "unavailable_after" contained in http header X-Robots-Tag |


**`metagenerator_t`** _(text_general)_ - content of `<meta name=\"generator\" content=#content#>` tag

**`inboundlinks_anchortext_txt`** _(text_general)_ - internal links, the visible anchor text

**`outboundlinks_anchortext_txt`** _(text_general)_ - external links, the visible anchor text

**`icons_urlstub_sxt`** _(string)_ - all icon links without the protocol and `://`

_All icon links protocols : split from `icons_urlstub` to provide some compression, as http protocol is implied as default and not
stored_

**`icons_protocol_sxt`** _(string)_ - all icon links protocols

**`icons_rel_sxt`** _(string)_ - all icon links relationships space separated _(e.g.. 'icon apple-touch-icon')_

**`icons_sizes_sxt`** _(string)_ - all icon sizes space separated (e.g. '16x16 32x32')

**`images_text_t`** _(text_general)_ - all text/words appearing in image alt texts or the tokenized url

**`images_alt_sxt`** _(string)_ - all image link alt tag  - no need to index this; don't turn it into a txt field; use `images_text_t` instead

**`images_height_val`** _(num_integer)_ - size of images:height

**`images_width_val`** _(num_integer)_ - size of images:width

**`images_pixel_val`** _(num_integer)_ - size of images as number of pixels (easier for a search restriction than width and height)

**`images_withalt_i`** _(num_integer)_ - number of image links with alt tag

**`htags_i`** _(num_integer)_ - binary pattern for the existance of h1..h6 headlines

**`canonical_s`** _(string)_ - url inside the canonical link element

**`canonical_equal_sku_b`** _(bool)_ - flag shows if the url in `canonical_t` is equal to sku

**`refresh_s`** _(string)_ - link from the url property inside the refresh link element

**`li_txt`** _(text_general)_ - all texts in `<li>` tags

**`licount_i`** _(num_integer)_ - number of `<li>` tags

**`dt_txt`** _(text_general)_ - all texts in `<dt>` tags

**`dtcount_i`** _(num_integer)_ - number of `<dt>` tags

**`dd_txt`** _(text_general)_ - all texts in `<dd>` tags

**`ddcount_i`** _(num_integer)_ - number of `<dd>` tags

**`article_txt`** _(text_general)_ - all texts in `<article>` tags

**`articlecount_i`** _(num_integer)_ - number of `<article>` tags

**`bold_txt`** _(text_general)_ - all texts inside of
`<b>` or `<strong>` tags. no doubles. listed in the order of number of occurrences in decreasing order

**`boldcount_i`** _(num_integer)_ - total number of occurrences of
`<b>` or `<strong>`

**`italic_txt`** _(text_general)_ - all texts inside of
`<i>` tags. no doubles. listed in the order of number of occurrences in decreasing order

**`italiccount_i`** _(num_integer)_ - total number of occurrences of `<i>`

**`underline_txt`** _(text_general)_ - all texts inside of
`<u>` tags. no doubles. listed in the order of number of occurrences in decreasing order

**`underlinecount_i`** _(num_integer)_ - total number of occurrences of
`<u>`

**`flash_b`** _(bool)_ - flag that shows if a adobe flash .swf file is linked

**`frames_sxt`** _(string)_ - list of all links to frames

**`framesscount_i`** _(num_integer)_ - number of frames_txt

**`iframes_sxt`** _(string)_ - list of all links to iframes

**`iframesscount_i`** _(num_integer)_ - number of iframes_txt

**`hreflang_url_sxt`** _(string)_ - url of the hreflang link tag, see <https://developers.google.com/search/docs/specialty/international/localized-versions>

**`hreflang_cc_sxt`** _(string)_ - country code of the hreflang link tag, see <https://developers.google.com/search/docs/specialty/international/localized-versions>

**`navigation_url_sxt`** _(string)_ - page navigation url, see <https://webmasters.googleblog.com/2011/09/pagination-with-relnext-and-relprev.html>

**`navigation_type_sxt`** _(string)_ - page navigation rel property value, can contain one of {top,up,next,prev,first,last}

**`publisher_url_s`** _(string)_ - publisher url as defined in <https://web.archive.org/web/20140530224715/https://support.google.com/plus/answer/1713826?hl=de>

**`url_protocol_s`** _(string)_ - the protocol of the url

**`url_file_name_s`** _(string)_ - the file name (which is the string after the last '/' and before the query part from '?' on) without the file extension

**`url_file_name_tokens_t`** _(text_general)_ - tokens generated from `url_file_name_s` which can be used for better matching and result boosting

**`url_paths_count_i`** _(num_integer)_ - number of all path elements in the url hpath (see: <https://www.ietf.org/rfc/rfc1738.txt>) without the file name

**`url_paths_sxt`** _(string)_ - all path elements in the url hpath (see: <https://www.ietf.org/rfc/rfc1738.txt>) without the file name

**`url_parameter_i`** _(num_integer)_ - number of key-value pairs in search part of the url

**`url_parameter_key_sxt`** _(string)_ - the keys from key-value pairs in the search part of the url

**`url_parameter_value_sxt`** _(string)_ - the values from key-value pairs in the search part of the url

**`url_chars_i`** _(num_integer)_ - number of all characters in the url == length of sku field

**`host_dnc_s`** _(string)_ - the Domain Class Name, either the TLD or a combination of ccSLD+TLD if a ccSLD is used.

**`host_organizationdnc_s`** _(string)_ - the organization and dnc concatenated with '.'

**`host_subdomain_s`** _(string)_ - the remaining part of the host without organizationdnc

**`host_extent_i`** _(num_integer)_ - number of documents from the same host; can be used to measure `references_internal_i` for likelihood computation

**`title_count_i`** _(num_integer)_ - number of titles (counting the 'title' field) in the document

**`title_chars_val`** _(num_integer)_ - number of characters for each title

**`title_words_val`** _(num_integer)_ - number of words in each title

**`description_count_i`** _(num_integer)_ - number of descriptions in the document. Its not counting the 'description' field since there is only one. But it counts the number of descriptions that appear in the document (if any)

**`description_chars_val`** _(num_integer)_ - number of characters for each description

**`description_words_val`** _(num_integer)_ - number of words in each description


**`h1_i`** _(num_integer)_ - number of h1 header lines

**`h2_i`** _(num_integer)_ - number of h2 header lines

**`h3_i`** _(num_integer)_ - number of h3 header lines

**`h4_i`** _(num_integer)_ - number of h4 header lines

**`h5_i`** _(num_integer)_ - number of h5 header lines

**`h6_i`** _(num_integer)_ - number of h6 header lines


**`schema_org_breadcrumb_i`** _(num_integer)_ - number of `itemprop="breadcrumb"` appearances in div tags

**`opengraph_title_t`** _(text_general)_ - Open Graph Metadata from `og:title` metadata field, see <https://ogp.me/>

**`opengraph_type_s`** _(text_general)_ - Open Graph Metadata from `og:type` metadata field, see <https://ogp.me/>

**`opengraph_url_s`** _(text_general)_ - Open Graph Metadata from `og:url` metadata field, see <https://ogp.me/>

**`opengraph_image_s`** _(text_general)_ - Open Graph Metadata from `og:image` metadata field, see <https://ogp.me/>


## link structure for ranking

**`cr_host_count_i`** _(num_integer)_ - the number of documents within a single host

**`cr_host_chance_d`** _(num_double)_ - the chance to click on this page when randomly clicking on links within on one host

**`cr_host_norm_i`** _(num_integer)_ - normalization of chance: 0 for lower halve of `cr_host_count_i urls`, 1 for 1/2 of the remaining and so on. the maximum number is 10


## custom rating
values to influence the ranking in combination with boost rules

**`rating_i`** _(num_integer)_ - custom rating; to be set with external rating information

## special values
can only be used if '_val' type is defined in schema file; this is not standard

**`bold_val`** _(num_integer)_ - number of occurrences of texts in `bold_txt`

**`italic_val`** _(num_integer)_ - number of occurrences of texts in `italic_txt`

**`underline_val`** _(num_integer)_ - number of occurrences of texts in `underline_txt`

**`ext_cms_txt`** _(text_general)_ - names of cms attributes; if several are recognized then they are listen in decreasing order of number of matching criterias

**`ext_cms_val`** _(num_integer)_ - number of attributes that count for a specific cms in `ext_cms_txt`

**`ext_ads_txt`** _(text_general)_ - names of ad-servers/ad-services

**`ext_ads_val`** _(num_integer)_ - number of attributes counts in ext_ads_txt

**`ext_community_txt`** _(text_general)_ - names of recognized community functions

**`ext_community_val`** _(num_integer)_ - number of attribute counts in attr_community

**`ext_maps_txt`** - _(text_general)_ names of map services

**`ext_maps_val`** _(num_integer)_ - number of attribute counts in ext_maps_txt

**`ext_tracker_txt`** _(text_general)_ - names of tracker server

**`ext_tracker_val`** _(num_integer)_ - number of attribute counts in `ext_tracker_txt`

**`ext_title_txt`** _(text_general)_ - names matching title expressions

**`ext_title_val`** _(num_integer)_ - number of matching title expressions

**`vocabularies_sxt`** _(string)_ - collection of all vocabulary names that have a matcher in the document - use this to boost with vocabularies
