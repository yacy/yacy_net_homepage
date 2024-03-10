# Use cases

This list describes [use cases](http://en.wikipedia.org/wiki/Use_case)
and the respective sequences of events that supply you with the desired
results using YaCy.

## Search Functions

### Alternative Web Search

You are looking for www documents, but - for different reasons
(availability, censorship, other search portals' ranking and sorting) -
you want to find websites that have been indexed by a community of
independent or topic-oriented (see: different networks; freeworld; TOR;
sciencenet) YaCy peers.

  - [Install](download_installation.md)
    a YaCy standard release without any modifications.
  - Open and use the YaCy search page.

### Portal Search

You own a web portal and need a search function for your pages. Users of
your website shall be able to find documents within your site or its
sub-domains. Users of the public YaCy network (freeworld) shall get
results containing links to your site.

  - [Install](download_installation.md)
    YaCy on your (v)server.
  - Switch to Robinson mode (unilateral index separation from other
    users).
  - Start a [web crawl](operation/crawlstart_p.md)
    that is restricted to your domain.
  - Integrate the YaCy search page into your web portal.

### Topic Search

You own a web portal on a special-interest topic and want to change it
into a search portal which offers a web search especially on this
subject. Your users shall be able to get search results from your site
and the sites you recommended alike from a single search dialogue.

  - [Install](download_installation.md) YaCy on your (v)server.
  - Switch to Robinson mode (unilateral index separation from other
    users).
  - Start several [web crawls](operation/crawlstart_p.md)
    that are restricted to your domain and the ones you want to include.
  - Integrate the YaCy search page into your web portal.

### Intranet Search

An intranet you administer needs a search function. Users of this search
shall be able to reach all pages of your intranet from a single search
page. (Use similar to a 'search appliance'; see: GSA)

  - [Install](download_installation.md)
    YaCy on a server inside your intranet.
  - Reconfigure the standard network affiliation to 'intranet'.
  - Start an unrestricted [web
    crawl](operation/crawlstart_p.md)
    with a page on your intranet (if interlinking exists) or to several
    pages, one for each intranet server.
  - Integrate the YaCy search page into your intranet portal.

### Collaborative Desktop Indexing

You and your colleagues need a common search function for documents
which are stored on your private computers and not on shared drives.
Each member of the group can restrict the shared use to certain
documents. All documents are to be published via a web service. A search
shall include all shared documents. Other persons' frequently-used
documents are to be accessed by means of a bookmark function.

  - All group members
    [install](download_installation.md)
    YaCy on their computers.
  - Reconfigure the standard network affiliation to 'intranet'.
  - All users publish their documents to be shared in their
    `<yacy-home>/DATA/HTDOCS/repository/` directory.
  - Everybody starts a [web
    crawl](operation/crawlstart_p.md)
    at the address `http://<local-ip>:8090/repository/`.
  - All users can find all their own documents and those of the other
    team members through their own YaCy search
    page
  - Found documents will be served automatically through YaCy's built-in
    web server.
  - Found documents can be bookmarked by means of YaCy's built-in
    function.
  - Users can publish their bookmarks.
  - Other users' published bookmarks can be imported as private ones.

  

## Personal Web Assistance

### Personal Bookmark Server

You have a huge number of bookmarks on your private and on your company
computer. You want to use all of them on both computers without
publishing them. While you are on a journey, you also want to be able to
access your personal bookmarks from any computer.

  - [Install](download_installation.md)
    YaCy on your home computer and enable public access via dyndns or
    install YaCy on a (v)server on the internet.
  - Export your bookmarks to YaCy. They can be accessed by tags.
  - For each entry, you can select if it is to be public or private.
  - On your company computer, you can access your bookmarks, for
    instance, through the
    [YaCyBar](https://github.com/yacy/YaCyBar)
    (Firefox plug-in) or the YaCy web front-end.
  - While on a journey, you can access your bookmarks through the YaCy
    web front-end.

  

## Web Analysis

### Detection of All Dead Links on Your Web Portal

You administer a web portal and want to remove faulty links from your
site.

  - [Install](download_installation.md)
    YaCy.
  - Switch to Robinson mode (unilateral index separation from other
    users).
  - Start a [web
    crawl](operation/crawlstart_p.md)
    that is restricted to the domain to be checked.
  - Examine the crawl log and filter out all messages about unreachable
    pages.
  - Use the unix/linux strings command to extract a comprehensive list
    of all dead links.

### Generation of a Domain List

You need a list of domain names which are accessible on-line and provide
contents.

  - [Install](download_installation.md)
    YaCy.
  - Start a [web
    crawl](operation/crawlstart_p.md)
    A good starting point is a highly-interlinked portal page.
  - Use the built-in export function for URL and domain lists. You can
    refine the exports using filters.

  


_Converted from
<https://wiki.yacy.net/index.php?title=En:Use_cases>, may be outdated_




