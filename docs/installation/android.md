# Android installation

First download and install termux app in your android device from this link
(choose your proper processor architecture):
 
<https://github.com/termux/termux-app/releases>
 
Second open the app and update the repositories and install the latest Java
and requirements with this command:
 
```
pkg update && pkg upgrade && pkg install openjdk-21 git ant which -y
```
 
Then clone the repository and build the application:
 
```
git clone --depth 1 https://github.com/yacy/yacy_search_server.git
cd yacy_search_server
ant clean all
```
 
To start YaCy, run `./startYACY.sh` Upon starting yacy, the browser must
launch the search page automatically.  Remember to allow termux to **Acquire
wakelock** by clicking on the notification so it doesn't pause.  And for a
better experience, open the appropiate port on your router's **portforward**
page.
 
Stop YaCy on the console with `./stopYACY.sh`
