# YaCy standalone documentation

This is an YaCy - p2p search engine - documentation, forked from the [official
homepage repository](https://github.com/yacy/yacy_net_homepage), made
standalone and hosted at <https://eldar.cz/yacydocs>.


## How to contribute documentation to the home page:

Your contribution is very welcome!
If you want to contribute, please clone this repository and make a pull request with your changes.

## How to edit/compile these web pages:

These web pages are made with the https://www.mkdocs.org CMS framework. Mkdocs compiles static web pages out of markdown text files.
We are using a mkdocs theme from https://github.com/Orbiter/MkDocs-Theme-Cinder-Superhero which is a bootstrap theme from https://bootswatch.com/superhero/ using the 'cinder' framework for mkdocs from https://sourcefoundry.org/cinder/

The set-up of a development system is very easy:

* Install MKDocs according to https://www.mkdocs.org/#installation
* Run `mkdocs serve` to host a live version of your documents, watch them at http://localhost:8000/
* Run `mkdocs build` to make a static web page out of your documentation inside `site`
* Edit the documentation markdown files in `docs` to make your own documentation
* before commiting, test CI/CD process with `mkdocs build --verbose --clean --strict`
