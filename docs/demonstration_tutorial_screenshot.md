# YaCy Demonstration

We have screenshots, tutorial movies, and a live demonstration. If you want to jump to the section where we show where we took the beautiful teaser image from, jump to the [peer-to-peer network activity dashboard](#network-activity)!

<p><a class="btn btn-default btn-sm pull-right" href="https://github.com/yacy/yacy_net_homepage/blob/master/docs/demonstration_tutorial_screenshot.md" role="button" target="_blank">Improve this doc</a>
</p>

## Screenshots
.. the best way to show what you get ..

### Search Results

This is the search results page using peer-to-peer data:
![YaCy Search Engine Result List](img/screenshot_search_result.png)

Search result pages can be configured:
![YaCy Search Engine Configuration](img/screenshot_search_result_configuration.png)

We provide a wide range of options to integrate a search page into an existing environment:
![YaCy Search Engine Integration](img/screenshot_search_result_integration.png)

There are many pre-defined themes and an easy way to configure your own colour schema:
![YaCy Search Engine Theme Configuration](img/screenshot_appearance.png)

Search result ranking can be configured:
![YaCy Search Engine Ranking Configuration](img/screenshot_ranking.png)

### Crawling

Before search results can be provided, a web crawl must be done to harvest the required document corpus.

There is a easy-to-use simple crawl start service which takes almost only the starting URL as input:
![YaCy Search Engine Site Crawler/Spider](img/screenshot_crawler_site.png)

A running crawl can be monitored in many ways, here is the crawler status dashboard:
![YaCy Search Engine Crawler/Spider Monitor](img/screenshot_crawler_monitor.png)

For more complex harvesting tasks, here is the Expert Crawl Start service:
![YaCy Search Engine Expert Crawl/Spider Start](img/screenshot_expert_crawl_start.png)


### Data Analysis

A running YaCy instance has many management tasks running and it creates a lot of data.
To visualize that data about itself and the data it harvested from the internet, there are a lot of
dashboards and monitoring features.

The status page which informs about the current activities of your YaCy instance:
![YaCy Search Engine Status Dashboard](img/screenshot_status.png)

Crawled web pages can be reconstructed and browsed with the host browser where you see the internal link structure and all kind of details of the parsing results:
![YaCy Search Engine Host Browser](img/screenshot_host_browser.png)

While the host browser reveals the structure of documents within all of the single domains, the web
structure service shows how domains are linked to each other:
![YaCy Search Engine Web Structure](img/screenshot_web_structure.png)

### Configuration

YaCy can be configured in every detail using the web interface. You can use a configuration file and also edit details inside of that file, but a web front-end is much more convenient.

Here you see the use case configuration. This is actually the first service which YaCy shows to you because the first thing you have to do is to choose which use case you are prefering: Peer-to-Peer operation, your own Search Portal, or Intranet Indexing:
![YaCy Search Engine Basic Configuration for Use Case: Peer-to-Peer, Portal, Intranet](img/screenshot_use_case_configuration.png)

The main purpose of YaCy is to aquire a lot of data from the web and make
them searchable.  Consequently, this uses a lot of disk space.  We make the
resources which YaCy takes configurable with the following service.  YaCy
loves to use more RAM if available, give it more RAM and it performs better!
![YaCy Search Engine Performance Setting](img/screenshot_performance_settings.png)


### Network Activity

YaCy makes a lot of network connections and it is transparent about doing that.

In case you are running YaCy in peer-to-peer operation, you can watch the network graphic here:
![YaCy Peer-to-Peer Network](img/screenshot_peer_network.png)

The peer-to-peer network can be investigated in detail in a table:
![YaCy Peer List Table](img/screenshot_peer_list.png)

Every connection that YaCy does, peer-to-peer or crawling, is monitored as well:
![YaCy Network Monitor](img/screenshot_access_grid.png)


## Tutorial Movies

We have a YouTube channel! Yes, thats a Google service - therefore all videos embedded here are mouseover-activated, that means as long as you do not touch them, there is no referrer appearing at a G server.

These videos are short and most have nice music from [Shiryu Music](https://shiryu.bandcamp.com/) in the background. Shiryu is just great and inspiring! 

<p><a class="btn btn-danger btn-lg" href="https://www.youtube.com/yacy_tutorials" role="button">Subscribe to the YaCy Tutorial Youtube channel</a></p>

<script>
    embed01 = "<iframe width='720' height='405' src='//www.youtube.com/embed/CFwebavBU0s?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
    embed02 = "<iframe width='720' height='405' src='//www.youtube.com/embed/XDoVNzOMoIo?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
    embed03 = "<iframe width='720' height='405' src='//www.youtube.com/embed/iqJuf_EA1UE?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
    embed04 = "<iframe width='720' height='405' src='//www.youtube.com/embed/t5y5MmnmraA?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
    embed05 = "<iframe width='720' height='405' src='//www.youtube.com/embed/UUAylWYqzac?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
    embed06 = "<iframe width='720' height='405' src='//www.youtube.com/embed/hGwjllUdjU0?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
    embed07 = "<iframe width='720' height='405' src='//www.youtube.com/embed/o3-v2oaXSa0?list=UUvy0FJxqOAlSZ2VXskej79Q' frameborder='0' allowfullscreen></iframe>"
</script>

### Demo: YaCy Installation in Windows
Please install Java 11 (or higher) first, the automatic Java installation within YaCy does not work any more.
<div id="video01">
<img src="../img/tutorial_01_Installation_in_Windows.png" alt="YaCy Tutorial 01: Installation in Windows" width="720" height="405"  onmouseover="document.getElementById('video01').innerHTML = embed01;">
</div>

### Demo: YaCy Installation on a Mac
<div id="video02">
<img src="../img/tutorial_02_Installation_on_a_Mac.png" alt="YaCy Tutorial 02: Installation on a Mac" width="720" height="405"  onmouseover="document.getElementById('video02').innerHTML = embed02;">
</div>

### Demo: YaCy Installation in Ubuntu and any other Linux Systems
Instead of Java 7 now please install Java 11 (or higher)
<div id="video03">
<img src="../img/tutorial_03_Installation_in_Ubuntu_and_any_other_Linux.png" alt="YaCy Tutorial 03: Installation in Ubuntu and any other Linux" width="720" height="405"  onmouseover="document.getElementById('video03').innerHTML = embed03;">
</div>

### Demo: Basic Configuration of YaCy and Release Updates
<div id="video04">
<img src="../img/tutorial_04_Basic_Configuration_Release_Update.png" alt="YaCy Tutorial 04: Basic Configuration" width="720" height="405"  onmouseover="document.getElementById('video04').innerHTML = embed04;">
</div>

### Demo: Start a Web Crawl with YaCy
<div id="video05">
<img src="../img/tutorial_05_Easy_Web_Crawl.png" alt="YaCy Tutorial 05: Easy Web Crawl"  width="720" height="405"  onmouseover="document.getElementById('video05').innerHTML = embed05;">
</div>

### Demo: Secret Agents with YaCy RSS Feed Reader
<div id="video06">
<img src="../img/tutorial_06_Secret_Agents_with_YaCy_RSS_Feed_Reader.png" alt="YaCy Tutorial 06: Secret Agents with YaCy RSS Feed Reader" width="720" height="405"  onmouseover="document.getElementById('video06').innerHTML = embed06;">
</div>

### Demo: Location Search with YaCy and Openstreetmap and Geonames
<div id="video07">
<img src="../img/tutorial_07_Search_Locations_on_Map_with_Openstreetmap_and_Geonames.png" alt="YaCy Tutorial 07: Search Locations on a Map with Openstreetmap and Geonames" width="720" height="405"  onmouseover="document.getElementById('video07').innerHTML = embed07;">
</div>


## Live Demonstration

Well, YaCy is all about running your own search engine, not using a central one. Therefore we highly recommend you download and try out your own YaCy instance instead of trying this demonstration. Therefore, please consider this demonstration not as production-grade search portal, just as help to find out what YaCy is and how it looks.

We provide here a link to the administration page of the test instance where you can also find your way to the search page. Administration functions are disabled but you are able to browse through the services without a password:

### YaCy Demo Peer
<p><a class="btn btn-default btn-lg" href="https://yacy.searchlab.eu/Status.html" role="button">Click here to operate a YaCy Demo Peer</a></p>
