# How to contribute to YaCy


## Be active in the forum

[Community forum](https://community.searchlab.eu) keeps the community alive.  
If you're advanced user, good place to start is helping the others in
the forum and sharing your knowledge there.


## Report a bug

If you find a bug or you want to suggest an improvement, fill the 
[github issue](https://github.com/yacy/yacy_search_server/issues).

Please use factual and technical language and try to describe the bug in
details. 

Focus on what behavior you did expect and what YaCy did instead of it.

See [the log](operation/logging.md) and try to find and attach the
appropriate log lines. Increase the log
[verbosity](operation/logging.md#verbosity), if neccessary.

Be sure, that the issue could be replicated (describe what to do to see
the malfunction again). Problem happening just once, without the possiblity
to make it happen again, could be hardly fixed.

Pace of issue-fixing is currently quite low, so if you can, repair the
function yourself and do a github pull-request (see below).


## Help writting documentation

YaCy has many more functions than described in the [documentation](docs.md)
and is still heavily under-documented.  You can help others by writting about your
favourite feature, updating the old pages, correcting the mistakes or just
spell-checking.  See 
[github repository of documentation](https://github.com/yacy/yacy_net_homepage), 
[documentation issues](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3ADocumentation) 
and github guide bellow.


## Help developing YaCy 

If you're a Java wizard, you're most warmly welcomed to be part of the
development!  

Although YaCy is developed [since 2003](https://en.wikipedia.org/wiki/YaCy), and still maintained,
progress is sometimes slow. Therefore chances for including your code to
mainstream are very high.

You can pick an [issue](https://github.com/yacy/yacy_search_server/issues) to solve.
They're well tagged with [labels](https://github.com/yacy/yacy_search_server/labels) such as: 
[good first issue](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3A%22good%20first%20issue%22),
[bug](https://github.com/yacy/yacy_search_server/issues?q=is%3Aissue%20state%3Aopen%20label%3Abug),
[crawler](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3Acrawler),
[search](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3Asearch),
[index](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3Aindex),
[network](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3Anetwork),
[releasing](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3Areleasing),
[developer](https://github.com/yacy/yacy_search_server/issues?q=state%3Aopen%20label%3A%22developer%20issue%22),
etc.
 
You can improve what annoys you, personally, or craft a feature you like.

Before adding a major feature, consult
[@orbiter](https://github.com/Orbiter), the main developer, or 
[the forum](https://community.searchlab.eu/).



## Step by step guide for Github

Basically, your contribution to the code and documentation is possible using
github.com. Create account there, fork the official repository, clone it to
your local machine, make a branch, modify files, commit changes to github. 
Finally make a pull request, so your contribution could be merged into
master branch.


(or follow the github contribution guide
<https://docs.github.com/en/get-started/quickstart/contributing-to-projects>)



### this is for the first time only

* create a github.com account

* log into github

* fork repository <https://github.com/yacy/yacy_search_server> for a yacy
  software modification, 
  or <https://github.com/yacy/yacy_net_homepage> for documentation editing, 
  respectively (use a 'fork' button on top right part of github.com)

* your own fork is now at url:
  https://github.com/YOURUSERNAMEHERE/yacy_net_homepage
  or:
  https://github.com/YOURUSERNAMEHERE/yacy_search_server

* set-up a ssh key using [this guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

* on your local machine, clone your new fork using commandline:
```
 git clone git@github.com:YOURUSERNAMEHERE/yacy_net_homepage.git
```
 or
```
 git clone git@github.com:YOURUSERNAMEHERE/yacy_search_server.git
```

* for the first time, attach the local working directory with yours github
  identity:
```
  git config --global user.email "you@example.com"
  git config --global user.name "YOURUSERNAMEHERE"
```

### for every next change

* create a new branch under your working directory:
```
  git branch BRANCH-NAME
  git checkout BRANCH-NAME
```
  where BRANCH-NAME is a name of your pack of changes

* make changes in any files you want to modify

* test if everything is working fine

* describe your changes and schedule for upload: 
```
  git add .
  git commit -m "a short description of the change"
```

* commit the changes to your repository on github:
```
  git push --set-upstream origin BRANCH-NAME
```

* in the github web, press "Contribute" and then 
  "Open a pull request" to pull your modification 
  to the master yacy branch. 

* you can see all open pull request by you and other people at:
  <https://github.com/yacy/yacy_search_server/pulls>
  or
  <https://github.com/yacy/yacy_net_homepage/pulls>
  
* wait until the mantainers merge your pull request

* if they don't, politely ask

* if in doubt, follow the [github contribution guide](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)

