disable_toc: true

<style>
body.homepage {
  overflow-x: hidden;
}
.home-hero {
  display: flex;
  align-items: center;
  gap: 36px;
  margin: 28px 0 44px 0;
}
.home-hero-copy {
  flex: 0 0 36%;
}
.home-hero-logo {
  width: 170px;
  height: auto;
  margin-bottom: 22px;
}
.home-hero h1 {
  margin-top: 0;
  font-size: 44px;
  line-height: 1.1;
}
.home-hero-copy p {
  font-size: 18px;
  line-height: 1.55;
}
.home-hero-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 24px;
}
.home-hero-screenshot {
  flex: 1 1 auto;
  min-width: 0;
}
.home-hero-screenshot img {
  display: block;
  width: 100%;
  height: auto;
  border: 1px solid rgba(255,255,255,0.22);
  box-shadow: 0 14px 40px rgba(0,0,0,0.35);
}
.use-case-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
  margin: 24px 0 42px 0;
}
.use-case-card {
  background-color: #4E5D6C;
  padding: 18px;
}
.use-case-card h2 {
  margin-top: 0;
}
.use-case-card img {
  display: block;
  width: 100%;
  height: auto;
  margin: 0 auto 14px auto;
}
.network-picture {
  display: block;
  width: 100%;
  max-width: 1170px;
  height: auto;
  margin: 18px auto 0 auto;
}
@media (max-width: 991px) {
  .home-hero {
    display: block;
    overflow-x: hidden;
  }
  .home-hero-copy {
    margin-bottom: 26px;
  }
  .home-hero h1 {
    font-size: 36px;
    overflow-wrap: anywhere;
  }
  .home-hero-actions {
    display: block;
  }
  .home-hero-actions .btn {
    display: block;
    width: 100%;
    margin: 0;
    white-space: normal;
  }
  .home-hero-actions .btn + .btn {
    margin-top: 10px;
  }
  .use-case-grid {
    grid-template-columns: 1fr;
  }
}
@media (max-width: 767px) {
  .home-hero-copy,
  .home-hero-screenshot {
    max-width: 360px;
  }
}
@media (max-width: 480px) {
  .home-hero {
    margin-top: 18px;
  }
  .home-hero h1 {
    font-size: 32px;
  }
  .home-hero-copy p {
    font-size: 16px;
  }
}
</style>

<section class="home-hero">
  <div class="home-hero-copy">
    <img class="home-hero-logo" src="img/YaCyLogo2011_240.png" alt="YaCy">
    <h1>YaCy is free software for your own search engine.</h1>
    <p>YaCy is free search engine software for local search, organization-wide search portals, and a decentralized peer-to-peer web index.</p>
    <div class="home-hero-actions">
      <a class="btn btn-success btn-lg" href="/download_installation/" role="button">Download YaCy</a>
      <a class="btn btn-default btn-lg" href="https://yacy.searchlab.eu/Status.html" role="button">Try Demo</a>
    </div>
  </div>
  <div class="home-hero-screenshot">
    <img src="img/screenshot_search_result.png" alt="YaCy search results interface">
  </div>
</section>

## Choose how you want to use YaCy

Run YaCy locally, build a search portal for your organization, or join the decentralized peer-to-peer search network.

<div class="use-case-grid">
  <div id="mode-p2p" class="use-case-card">
    <h2>P2P Mode</h2>
    <img src="img/usecase_freeworld.png" alt="YaCy Use Case: Freeworld">
    <p>Web Search by the people, for the people: decentralized, all users are equal, no central, no search request storage, shared index.</p>
  </div>
  <div id="mode-portal" class="use-case-card">
    <h2>Your Search Portal</h2>
    <img src="img/usecase_webportal.png" alt="YaCy Use Case: Web Portal">
    <p>Your YaCy installation is independent from other peers. Define your own web index and start your own web crawl.</p>
  </div>
  <div id="mode-intranet" class="use-case-card">
    <h2>Intranet Search</h2>
    <img src="img/usecase_intranet.png" alt="YaCy Use Case: Intranet">
    <p>Create a search portal for your intranet, web pages or your (shared) file system.</p>
  </div>
</div>

## Decentralization
YaCy does not depend on a central search provider. In peer-to-peer mode, many independently run devices contribute to a shared search index, so no single company or server controls the network.

Here is a live image of the YaCy network:

<img id="NetworkPicture" class="network-picture" src="https://yacy.searchlab.eu/NetworkPicture.png?width=1170&height=878&bgcolor=2C3E4F&pal=10080&pol=10080&coronaangle=0" alt="YaCy P2P Network" width="1170" height="878" />
      
<script type="text/javascript">
  <!--
    imagestub = "https://yacy.searchlab.eu/NetworkPicture.png?width=1170&height=878&bgcolor=2C3E4F&pal=10080&pol=10080&coronaangle=";
    imageanimindex = 0;
    imageloadindex = 0;
    imagecycles = 0;
    imagearray = new Array(6);
    setTimeout("initanimation()", 100);
    setTimeout("doanimation()", 1000);
    function initanimation() {
      handle = new Date().getTime();
      for (j = 0; j < 6; j++) initanimationphase(j, handle);
    }
    function initanimationphase(phase, handle) {
      imagearray[phase] = new Image(1024, 720);
      angle = phase * 60;
      imagearray[phase].src = imagestub + angle + "&handle=" + handle;
    }
    function doanimation() {
      var networkPicture = document.getElementById("NetworkPicture");
      if (networkPicture != null) {
        networkPicture.src = imagearray[imageanimindex].src;
        imageanimindex++;
        if (imageanimindex == 6) { imageanimindex = 0; }
        imagecycles++;
        if (imagecycles == 25) {
          initanimationphase(imageloadindex, new Date().getTime());
          imageloadindex++;
          if (imageloadindex == 6) { imageloadindex = 0; }
          imagecycles = 0;
        }
        setTimeout("doanimation()", 100);
      }
    }
  -->
  </script>
