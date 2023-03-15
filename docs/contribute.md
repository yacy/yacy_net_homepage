# How to contribute to source code and documentation?

Basically, your contribution to the code and documentation is possible using
github.com. Create account there, fork the official repository, clone it to
your local machine, make a branch, modify files, commit changes to github. 
Finally make a pull request, so your contribution could be merged into
master branch.

Step by step guide:

(or follow the github contribution guide
https://docs.github.com/en/get-started/quickstart/contributing-to-projects)



## this is for the first time only

* create a github.com account

* log into github

* fork repository https://github.com/yacy/yacy_search_server for a yacy
  software modification, 
  or https://github.com/yacy/yacy_net_homepage for documentation editing, 
  respectively (use a 'fork' button on top right part of github.com)

* your own fork is now at url:
  https://github.com/YOURUSERNAMEHERE/yacy_net_homepage
  or:
  https://github.com/YOURUSERNAMEHERE/yacy_search_server

* set-up a ssh key using this guide:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

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

## this is the regular workflow: 

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
  https://github.com/yacy/yacy_search_server/pulls
  or
  https://github.com/yacy/yacy_net_homepage/pulls
  
* wait until the mantainers merge your pull request

* if they don't, politely ask

* if in doubt, follow the [github contribution guide](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)

