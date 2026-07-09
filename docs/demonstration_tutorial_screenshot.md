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
.video-preview {
  display: block;
  position: relative;
  width: 100%;
  max-width: 720px;
  margin: 10px 0 26px 0;
  padding: 0;
  overflow: hidden;
  color: #ffffff;
  background-color: #111111;
  border: 1px solid rgba(255,255,255,0.2);
  cursor: pointer;
}
.video-preview img {
  display: block;
  width: 100%;
  height: auto;
}
.video-preview span {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  padding: 12px 18px;
  font-weight: 700;
  line-height: 1;
  white-space: nowrap;
  background-color: rgba(218,54,43,0.95);
  border-radius: 4px;
}
.video-preview:hover span,
.video-preview:focus span {
  background-color: #da362b;
}
.video-frame {
  max-width: 720px;
  margin: 10px 0 26px 0;
  aspect-ratio: 16 / 9;
}
.video-frame iframe {
  display: block;
  width: 100%;
  height: 100%;
  border: 0;
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

The YaCy tutorial videos are hosted on YouTube. To avoid loading YouTube automatically, this page shows local preview images first. Click a preview to load the video.

<p><a class="btn btn-danger btn-lg" href="https://www.youtube.com/yacy_tutorials" role="button">Open YaCy Tutorial Channel</a></p>

<script>
document.addEventListener('DOMContentLoaded', function () {
  var previews = document.querySelectorAll('.video-preview');
  previews.forEach(function (preview) {
    preview.addEventListener('click', function () {
      var videoId = preview.getAttribute('data-video-id');
      var title = preview.getAttribute('data-video-title') || 'YaCy tutorial video';
      var frameWrap = document.createElement('div');
      var iframe = document.createElement('iframe');

      frameWrap.className = 'video-frame';
      iframe.src = 'https://www.youtube-nocookie.com/embed/' + encodeURIComponent(videoId) + '?autoplay=1&rel=0&list=UUvy0FJxqOAlSZ2VXskej79Q';
      iframe.title = title;
      iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';
      iframe.allowFullscreen = true;

      frameWrap.appendChild(iframe);
      preview.replaceWith(frameWrap);
    });
  });
});
</script>

### YaCy Installation on Windows
Install the latest Java release before installing YaCy on Windows.
<div id="video01">
<button class="video-preview" type="button" data-video-id="CFwebavBU0s" data-video-title="YaCy Tutorial 01: Installation in Windows">
  <img src="../img/tutorial_01_Installation_in_Windows.png" alt="YaCy Tutorial 01: Installation in Windows" width="720" height="405">
  <span>Load video</span>
</button>
</div>

### YaCy Installation on macOS
<div id="video02">
<button class="video-preview" type="button" data-video-id="XDoVNzOMoIo" data-video-title="YaCy Tutorial 02: Installation on a Mac">
  <img src="../img/tutorial_02_Installation_on_a_Mac.png" alt="YaCy Tutorial 02: Installation on a Mac" width="720" height="405">
  <span>Load video</span>
</button>
</div>

### YaCy Installation on Ubuntu and Other Linux Systems
Install the latest Java release before installing YaCy on Linux.
<div id="video03">
<button class="video-preview" type="button" data-video-id="iqJuf_EA1UE" data-video-title="YaCy Tutorial 03: Installation in Ubuntu and any other Linux">
  <img src="../img/tutorial_03_Installation_in_Ubuntu_and_any_other_Linux.png" alt="YaCy Tutorial 03: Installation in Ubuntu and any other Linux" width="720" height="405">
  <span>Load video</span>
</button>
</div>

### Basic Configuration and Release Updates
<div id="video04">
<button class="video-preview" type="button" data-video-id="t5y5MmnmraA" data-video-title="YaCy Tutorial 04: Basic Configuration">
  <img src="../img/tutorial_04_Basic_Configuration_Release_Update.png" alt="YaCy Tutorial 04: Basic Configuration" width="720" height="405">
  <span>Load video</span>
</button>
</div>

### Start a Web Crawl with YaCy
<div id="video05">
<button class="video-preview" type="button" data-video-id="UUAylWYqzac" data-video-title="YaCy Tutorial 05: Easy Web Crawl">
  <img src="../img/tutorial_05_Easy_Web_Crawl.png" alt="YaCy Tutorial 05: Easy Web Crawl" width="720" height="405">
  <span>Load video</span>
</button>
</div>

### YaCy RSS Feed Reader
<div id="video06">
<button class="video-preview" type="button" data-video-id="hGwjllUdjU0" data-video-title="YaCy Tutorial 06: Secret Agents with YaCy RSS Feed Reader">
  <img src="../img/tutorial_06_Secret_Agents_with_YaCy_RSS_Feed_Reader.png" alt="YaCy Tutorial 06: Secret Agents with YaCy RSS Feed Reader" width="720" height="405">
  <span>Load video</span>
</button>
</div>

### Location Search with YaCy, OpenStreetMap, and Geonames
<div id="video07">
<button class="video-preview" type="button" data-video-id="o3-v2oaXSa0" data-video-title="YaCy Tutorial 07: Search Locations on a Map with OpenStreetMap and Geonames">
  <img src="../img/tutorial_07_Search_Locations_on_Map_with_Openstreetmap_and_Geonames.png" alt="YaCy Tutorial 07: Search Locations on a Map with OpenStreetMap and Geonames" width="720" height="405">
  <span>Load video</span>
</button>
</div>
