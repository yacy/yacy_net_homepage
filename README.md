# YaCy.net Home Page

This is the home page of the YaCy project at https://yacy.net.

The live page at yacy.net is built and hosted on a self-hosted server.

## How to contribute documentation to the home page:

Your contribution is very welcome!
If you want to contribute, please clone this repository and make a pull request with your changes.

Please keep the privacy model of the homepage intact:

* Do not add externally hosted JavaScript, CSS, fonts, images, analytics, trackers, or CDN resources.
* Store required assets in this repository and serve them from the YaCy-hosted site.
* Prefer relative links for site resources and same-origin runtime assets.

## How to edit/compile these web pages:

These web pages are made with the https://www.mkdocs.org CMS framework. MkDocs compiles static web pages out of Markdown text files.
We are using a MkDocs theme from https://github.com/Orbiter/MkDocs-Theme-Cinder-Superhero which is a Bootstrap theme from https://bootswatch.com/superhero/ using the 'cinder' framework for MkDocs from https://sourcefoundry.org/cinder/

Repository layout:

* `docs/` contains the Markdown source pages.
* `cinder-superhero/` contains the custom MkDocs theme.
* `mkdocs.yml` contains the site metadata, navigation, theme configuration, and Markdown extensions.
* `site/` contains generated output from `mkdocs build`; edit source files instead of generated HTML.
* `Dockerfile` builds the static site and serves it with nginx.

The setup of a development system is very easy:

* Install MkDocs according to https://www.mkdocs.org/#installation
* Or install it with `python3 -m pip install mkdocs`
* Run `mkdocs serve` to host a live version of your documents, watch them at http://localhost:8000/
* Run `mkdocs build` to make a static web page out of your documentation inside `site`
* Edit the documentation markdown files in `docs` to make your own documentation
* Before committing, test the build process with `mkdocs build --verbose --clean --strict`

## Docker

You can also build and serve the homepage with Docker:

```
docker build -t yacy_net_homepage .
docker run --rm -p 8080:8080 yacy_net_homepage
```
