# Headless - YaCy on a Remote Server

YaCy is (also) a server software which can be installed on a root server. YaCy can be remotely administrated on such a server. Either use the Debian version or the tarball release:

## Extract the tarball and start YaCy
If you don't use the Debian version you can install YaCy anywhere, even without a root account:

```
sudo apt-get install wget openjdk-7-jre-headless
wget http://yacy.net/release/yacy_v1.80_20140916_9000.tar.gz
tar xfz yacy_v1.80_20140916_9000.tar.gz
cd yacy
./startYACY.sh
```

## Set a YaCy administration password

The main difference during installation phase is the setting of the YACy 'admin' account: while all reqeuests coming from localhost are automatically authorized, this does not help to administrate YaCy if it is installed on a remote server because all requests to the YaCy web pages are remote. YaCy allows requests from remote within the first ten minutes and then sets a random password automatically. If this happens before you set your own administration password, you must reset the password.

## Set the Password before YaCy sets a Random Password

Open /ConfigAccounts_p.html on your remote YaCy (i.e. if the IP of your server is 1.2.3.4, then open http://1.2.3.4:8090/ConfigAccounts_p.html), switch on "Access only with qualified account" and set a password in the field "New Peer Password". Right after you click on "Define Administrator" you will be requested to log in; use your new password. You can also change the password here again if you remember the old password.

### Re-Set the Administration Password if You Lost the Old Password
This can only be done by someone who can log into the server account which is running YaCy. The following can only be done while YaCy is running! Log in into your server and then do:

```
# cd to the YaCy home directory
cd bin
./passwd.sh <mynewpassword> 
```

The account name will be 'admin', your new password is <mynewpassword>. If this does not work, try the 'Configure YaCy' option from the next section.

### Configure YaCy using the Linux Command Shell

There are a few attributes that you can configure using the command shell, including the password. The following can only be done when YaCy is NOT running:

```
# cd to the YaCy home directory
./reconfigureYACY.sh
If this does not work for you to reset the password, try the next section.
```

### Remove the Password from yacy.conf
The password is stored in hashed form in the file <yacy-home>DATA/SETTINGS/yacy.conf The following can only be done when YaCy is NOT running: open <yacy-home>DATA/SETTINGS/yacy.conf and do the following changes:

* remove property serverAccountBase64MD5
* remove property adminAccount
* set property serverAccount to <account>:<password>, i.e. serverAccount=admin:mysecretpassword

When YaCy is started the next time, the serverAccount is encrypted and removed to prevent that the property is there in cleartext form.
