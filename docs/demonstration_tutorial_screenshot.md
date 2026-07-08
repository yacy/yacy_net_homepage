# YaCy Demonstration

See what YaCy looks like in practice: search results, crawling, configuration, monitoring, and a public demo instance.

<p>
  <a class="btn btn-success btn-lg" href="https://yacy.searchlab.eu/Status.html" role="button">Try Demo</a>
  <a class="btn btn-default btn-lg" href="/download_installation/" role="button">Download YaCy</a>
</p>

<style>
.demo-shot {
  margin: 16px 0 26px 0;
}
.demo-shot img {
  display: block;
  width: 100%;
  height: auto;
  background-color: #fff;
  border: 1px solid rgba(255,255,255,0.2);
}
.demo-shot figcaption {
  margin-top: 8px;
  color: #B1B7B9;
  font-size: 14px;
  line-height: 1.45;
}
.demo-shot-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
  margin: 18px 0 34px 0;
}
.demo-shot-grid .demo-shot {
  margin: 0;
}
@media (max-width: 767px) {
  .demo-shot-grid {
    grid-template-columns: 1fr;
  }
}
</style>

## Screenshots

The screenshots below follow the main YaCy workflows: search, crawl, analyze, configure, and monitor the peer-to-peer network.

### Search

YaCy can search a local index, a portal index, or peer-to-peer data from the shared network. The result page is the main interface your users will see.

<figure class="demo-shot demo-shot-primary">
  <img src="../img/screenshot_search_result.png" alt="YaCy Search Engine Result List">
  <figcaption>Search results using peer-to-peer data.</figcaption>
</figure>

<div class="demo-shot-grid">
  <figure class="demo-shot">
    <img src="../img/screenshot_search_result_configuration.png" alt="YaCy Search Engine Configuration">
    <figcaption>Search page configuration for different use cases.</figcaption>
  </figure>
  <figure class="demo-shot">
    <img src="../img/screenshot_search_result_integration.png" alt="YaCy Search Engine Integration">
    <figcaption>Options for integrating search into an existing website or application.</figcaption>
  </figure>
  <figure class="demo-shot">
    <img src="../img/screenshot_appearance.png" alt="YaCy Search Engine Theme Configuration">
    <figcaption>Predefined themes and settings for custom colors.</figcaption>
  </figure>
  <figure class="demo-shot">
    <img src="../img/screenshot_ranking.png" alt="YaCy Search Engine Ranking Configuration">
    <figcaption>Ranking controls for tuning result ordering.</figcaption>
  </figure>
</div>

### Crawl

Before YaCy can return search results, it needs content in the index. A crawl starts with a source URL and can be kept simple for common tasks.

<figure class="demo-shot demo-shot-primary">
  <img src="../img/screenshot_crawler_site.png" alt="YaCy Search Engine Site Crawler/Spider">
  <figcaption>The simple crawl start page focuses on the basic input needed to begin.</figcaption>
</figure>

<div class="demo-shot-grid">
  <figure class="demo-shot">
    <img src="../img/screenshot_crawler_monitor.png" alt="YaCy Search Engine Crawler/Spider Monitor">
    <figcaption>Running crawls can be monitored while YaCy fetches and indexes documents.</figcaption>
  </figure>
  <figure class="demo-shot">
    <img src="../img/screenshot_expert_crawl_start.png" alt="YaCy Search Engine Expert Crawl Start">
    <figcaption>The expert crawl page exposes advanced options for complex harvesting tasks.</figcaption>
  </figure>
</div>


### Analyze

A running YaCy instance continuously records what it is doing. The administration interface includes dashboards for activity, indexed documents, and link structure.

<figure class="demo-shot demo-shot-primary">
  <img src="../img/screenshot_status.png" alt="YaCy Search Engine Status Dashboard">
  <figcaption>The status page shows current activity and health information.</figcaption>
</figure>

<div class="demo-shot-grid">
  <figure class="demo-shot">
    <img src="../img/screenshot_host_browser.png" alt="YaCy Search Engine Host Browser">
    <figcaption>Crawled pages can be inspected with parsed content and internal links.</figcaption>
  </figure>
  <figure class="demo-shot">
    <img src="../img/screenshot_web_structure.png" alt="YaCy Search Engine Web Structure">
    <figcaption>The web structure view shows how domains link to each other.</figcaption>
  </figure>
</div>

### Configure

YaCy can be configured through the web interface. You can still edit configuration files directly, but most operational settings are easier to manage in the browser.

<figure class="demo-shot demo-shot-primary">
  <img src="../img/screenshot_use_case_configuration.png" alt="YaCy Search Engine Basic Configuration for Use Case: Peer-to-Peer, Portal, Intranet">
  <figcaption>The use case configuration is one of the first decisions: peer-to-peer search, a standalone search portal, or intranet indexing.</figcaption>
</figure>

<div class="demo-shot-grid">
  <figure class="demo-shot">
    <img src="../img/screenshot_performance_settings.png" alt="YaCy Search Engine Performance Setting">
    <figcaption>Performance settings help you adapt YaCy to the machine it runs on.</figcaption>
  </figure>
</div>


### Network

In peer-to-peer mode, YaCy is transparent about its network activity and the peers it communicates with.

<figure class="demo-shot demo-shot-primary">
  <img src="../img/screenshot_peer_network.png" alt="YaCy Peer-to-Peer Network">
  <figcaption>The network graphic visualizes peer-to-peer activity.</figcaption>
</figure>

<div class="demo-shot-grid">
  <figure class="demo-shot">
    <img src="../img/screenshot_peer_list.png" alt="YaCy Peer List Table">
    <figcaption>The peer list provides a table view of known peers.</figcaption>
  </figure>
  <figure class="demo-shot">
    <img src="../img/screenshot_access_grid.png" alt="YaCy Network Monitor">
    <figcaption>The access grid shows connections made by crawling and peer-to-peer communication.</figcaption>
  </figure>
</div>


## Video Tutorials

The YaCy tutorial videos are hosted on YouTube. To avoid loading YouTube automatically, this page shows local preview images first. The video iframe is loaded only when you interact with a preview.

<p><a class="btn btn-danger btn-lg" href="https://www.youtube.com/yacy_tutorials" role="button">Open YaCy Tutorial Channel</a></p>

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
