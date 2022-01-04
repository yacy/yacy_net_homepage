disable_toc: true

<style>
body {
     background-image: url("img/YaCy_Network_Dark.png");
     background-repeat:no-repeat;
     background-size: 100%;
} 
</style>
<div class="jumbotron" style="background: none;"><div class="container">
  <img src="img/YaCyLogo2011_240.png" width="240">
  <h2>Search Engine Software</h2>
</div></div>

# YaCy is free software for your own search engine.

Join a community of search engines or make your own search portal!

There are these three use cases you can choose from:

<div class="container">
      <div class="row">
        <div id="mode-p2p" class="col-md-4" style="background-color:#4E5D6C; margin-right:15px; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h2>P2P Mode</h2>
	  <img src="img/usecase_freeworld.png">
          <p>Web Search by the people, for the people: completely decentralized, shared indexing, all users are equal, no search request storage.</p>
        </div>
        <div id="mode-portal" class="col-md-4" style="background-color:#4E5D6C; margin-right:15px; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h2>Your Search Portal</h2>
	  <img src="img/usecase_webportal.png">
          <p>Your YaCy installation is independent from other peers. Define your own web index and starting your own web crawl.</p>
       </div>
        <div id="mode-intranet" class="col-md-4" style="background-color:#4E5D6C; padding-left:15px; padding-right:15px; position:relative; left:15px;">
          <h2>Intranet Search</h2>
	  <img src="img/usecase_intranet.png">
          <p>Create a search portal for your intranet or web pages or your (shared) file system.</p><br/>
        </div>
      </div>
</div>

<script>
function setSpace() {
  w = window.innerWidth || document.documentElement.clientWidth || doc.getElementsByTagName('body')[0].clientWidth;
  margin = w * 0.4 - 360;
  if (margin < -40) {
     document.body.style.backgroundImage = 'none';
     document.body.style.backgroundImage = 'url("img/YaCy_Network_Dark_Small.png")';
     margin = -40;
  }
  jumbotron = document.getElementsByClassName('jumbotron')[0];
  jumbotron.style = 'background: none; margin-bottom: ' + margin + 'px;'

  c1 = document.getElementById("mode-portal").scrollHeight;
  if (document.readyState === 'complete') {
    document.getElementById("mode-p2p").style.height = c1 + "px";
    document.getElementById("mode-intranet").style.height = c1 + "px";
  }
}
setSpace();
window.onresize = setSpace;
</script>

## Decentralization
Imagine if, rather than relying on the proprietary software of a large professional search engine operator, your search engine was run across many private devices, not under the control of any one company or individual. Well, that's what YaCy does!

Here is a live image of the YaCy network:

![YaCy P2P Network](https://yacy.searchlab.eu/NetworkPicture.png?width=960&height=720&bgcolor=2C3E4F&pal=10080&pol=10080)

## Installation is easy!

The installation takes only three minutes. Just download the release, decompress the package and run the start script.

Next Steps:
<p><a class="btn btn-success btn-lg" href="/download_installation/" role="button">Download and Install YaCy</a>
<a class="btn btn-info btn-lg" href="/demonstration_tutorial_screenshot/" role="button">Watch screenshots and tutorial movies</a>
<a class="btn btn-warning btn-lg" href="https://yacy.searchlab.eu/Status.html" role="button">Try out the YaCy Demo Peer</a>
</p>
