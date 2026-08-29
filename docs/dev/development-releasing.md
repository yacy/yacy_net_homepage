# YaCy Development and Releasing


## Repository
Main repository for YaCy is <https://github.com/yacy/yacy_search_server>

For sake of simplicity, development is done in 'master' branch, there is no separate
development/experimental branch.

Version number is usually incremented with a major feature. 

As of habit, second decimal minor version number is incremented while upgrading
solr from one version to greater, such as 1.93 -> 1.94. Note that solr is
usually able to upgrade only one major version up. 

"Stable" releases are
[tagged](https://github.com/yacy/yacy_search_server/tags) with
'Release_versionnumber' tags.

[All development-related issues](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3A%22developer%20issue%22) are tagged
in Github Issues.

In case of functionality change, please make sure you updated the
[documentation](https://yacy.net/docs/) in a separate [docs repository](https://github.com/yacy/yacy_net_homepage)
as well.


## Build

YaCy is currently built using 'ant', which takes care of all library dependencies.
See [README.md](https://github.com/yacy/yacy_search_server/?tab=readme-ov-file#compile-and-run-yacy-from-git-sources)

Transition to Maven is [in progress](https://github.com/yacy/yacy_search_server/pull/710)
and would need help.

Historically, 'gradle' was used to build, later removed, but could be
excavated [as of here](https://github.com/yacy/yacy_search_server/commit/167373025d20fbabafbb04cd5c226676ffe47848)
by anyone who likes to use specifically Gradle for debugging.


## Releasing

[All issues related to releasing](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3Areleasing) are tagged
at Github Issues.

### auto builds from github - 'latest' (by each PR)
* auto-built by [ant-build.yaml](https://github.com/yacy/yacy_search_server/blob/master/.github/workflows/ant-build.yaml)
  and [ant-build-pull-request.yaml](https://github.com/yacy/yacy_search_server/blob/master/.github/workflows/ant-build-pull-request.yaml)
  workflows ? ? ?
* published at <https://release.yacy.net/yacy_latest.tar.gz>
* (broken now?)

* Docker images for platforms `linux/amd64` and `linux/arm64` published on
  [Docker Hub](https://hub.docker.com/r/yacy/yacy_search_server/tags),
  built by [build-docker-image.yaml](https://github.com/yacy/yacy_search_server/blob/master/.github/workflows/build-docker-image.yaml)
  workflow.


### 'official' releases (signed)

#### Linux
* done by hand, signed by @orbiter

#### MacOS
* done by
  [package_macos_app.sh](https://github.com/yacy/yacy_search_server/blob/master/package_macos_app.sh)

#### Windows 
* Windows installers are built with NSIS, see [README.md](https://github.com/yacy/yacy_search_server/?tab=readme-ov-file#build-the-windows-installer)



### 3rd party distribution ('un-official')

* [Snap package](https://snapcraft.io/yacy-search) by Luccioman (old! - 1.921)
