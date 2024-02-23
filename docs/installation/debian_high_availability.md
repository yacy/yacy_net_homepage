# YaCy High-Availability Configuration on Debian

A high-availabilty configuration is usually ensured using a redundant
set-up of a product. We will do this with YaCy in the following way:

  - run two YaCy instances, one will be the master node and the other is
    a replication node
  - set-up index replication between both nodes
  - add a full index back-up as a regular and automatic process
  - add an automatic peer re-start on peer failure
  - add automated software update without service downtime

A picture of this set-up can be found here:
<http://yacy.net/material/YaCy_High_Availability_Configuration.png>

## Prepare Debian

We will not use the [Debian
Installation](./debianinstall.md) process here
because we want to install two YaCy peers on the same computer. We will
use the tarball release of YaCy and put the same application in two
separate directories. We will use a linux account `yacyappliance` for
the home of the application. Therefore we first create this user. You
can omit this step and use an existing user `{myuser}` instead; if you do
so, replace all `~yacyappliance` with `~{myuser}` and `/home/yacyappliance`
with `/home/{myuser}`.

As root, do:

    adduser yacyappliance

We will use some debian packes:

    apt-get update
    apt-get install ant openjdk-7-jdk openjdk-7-jre-headless git wget

Then log in into the new account yacyappliance.

## Install Redundant YaCy Applications

We could use the official tarball from yacy.net here but to get full
availability of YaCy updates without the dependency on official update
servers we will use a self-generated YaCy update taken from the git
repository.

As user yacyappliance do

    cd
    git clone git://github.com/yacy/yacy_search_server.git yacy_deploy
    cd yacy_deploy
    ant clean all dist

This writes a fresh YaCy tarball release to
`~yacyappliance/yacy_deploy/RELEASE/`

We will unpack this tarball twice and create the two YaCy peers yacy0
(the master) and yacy1 (the replication peer).

    cd
    mkdir yacy0
    mkdir yacy1
    cd yacy_deploy/RELEASE
    tar xfz `ls -1tr | tail -1` -C ../../yacy0 --strip-components=1
    tar xfz `ls -1tr | tail -1` -C ../../yacy1 --strip-components=1

We can now update the peers yacy0 and yacy1 just by overwriting the
current code with new code that we create ourself (don't do this now\!):

    cd ~/yacy_deploy && git pull origin master && ant clean all dist
    cd ~/yacy_deploy/RELEASE && tar xfz `ls -1tr | tail -1` -C ../../yacy0 --strip-components=1
    cd ~/yacy_deploy/RELEASE && tar xfz `ls -1tr | tail -1` -C ../../yacy1 --strip-components=1

Now prepare the peer yacy0 to use the 'allip' network which will allow
you to index both, intranet and internet addresses without connecting
the YaCy P2P network: edit the file `~/yacy0/defaults/yacy.init` and
search the line containing network.unit.definition, set the value of
that property to `defaults/yacy.network.allip.unit`

You can now start YaCy the first time to set an administration account.
This is needed to configure the second peer yacy1 based on the content
of the first peer yacy0

    ~/yacy0/startYACY.sh
    ~/yacy0/bin/passwd.sh {newpassword}
    ~/yacy0/stopYACY.sh 

Now the DATA directory in `~/yacy0` was created and we can clone this to
yacy1, run

    cp -R ~/yacy0/DATA ~/yacy1/DATA && sed "s/port=8090/port=8091/" -i ~/yacy1/DATA/SETTINGS/yacy.conf && rm -f ~/yacy1/DATA/WORK/api.bheap

The second peer needs a different port. Therefore the sed command
replaces the port 8090 by 8091. We also do not want that the second peer
does the same crawling as configured in yacy0, therefore we also delete
the api file. We need this command later, therefore we create a file
`~/replicate_all.sh` with the following content:

    ~/yacy0/stopYACY.sh
    cp -R ~/yacy0/DATA ~/yacy1/DATA_NEW
    sed "s/port=8090/port=8091/" -i ~/yacy1/DATA_NEW/SETTINGS/yacy.conf
    rm -f ~/yacy1/DATA_NEW/WORK/api.bheap
    ~/yacy0/startYACY.sh
    ~/yacy1/stopYACY.sh
    rm -f ~/yacy1/DATA
    mv ~/yacy1/DATA_NEW ~/yacy1/DATA
    ~/yacy1/startYACY.sh

We will install a load balancer for the two peers later and because this
script ensures that one of the peers runs at any time, this is a update
replication of the complete peer configuration. But because we can do an
index-only replication as well during uptime of the peer, you should use
that script only if you do a reconfiguration of the primary peer.

We can now start both peers

    ~/yacy0/startYACY.sh && ~/yacy1/startYACY.sh

## Adding a https Gateway in Front of the Administration Interface

Security is part of an availability strategy and therefore all
production modifications should be made through a secure interface. To
apply a ssl encryption in front of the primary peer, follow the
instructions in
[YaCy Over HTTPS](../operation/yacyoverhttps.md)

## Auto-Start for YaCy

Because the two YaCys are not installed using the debian package
manager, there is no autostart for these applications. We will create
the autostart manually. Become root and create a file in
/etc/init.d/yacy with the following content:

    #! /bin/sh
    ### BEGIN INIT INFO
    # Provides:          YaCy
    # Required-Start:    $local_fs $remote_fs $network $time
    # Required-Stop:     $local_fs $remote_fs $network $time
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: YaCy Search Engine
    ### END INIT INFO
    case "$1" in
     start)
      su - yacyappliance -c "/home/yacyappliance/yacy0/startYACY.sh"
      su - yacyappliance -c "/home/yacyappliance/yacy1/startYACY.sh"
      ;;
     stop)
      su - yacyappliance -c "/home/yacyappliance/yacy0/stopYACY.sh"
      su - yacyappliance -c "/home/yacyappliance/yacy1/stopYACY.sh"
      ;;
     *)
      exit 3
      ;;
    esac
    :

and make it executable and linked with

    sudo chmod 755 /etc/init.d/yacy
    sudo update-rc.d yacy defaults

This will start and stop both YaCy instances automatically.

## Fail-Over Access to Redundant YaCy Installations using a Reverse Proxy

We will use a nginx http server and use it as a reverse proxy with
fail-over as load balancer for the two YaCy that we are running now.
Become root, run

    apt-get install nginx

and edit the file /etc/nginx/nginx.conf. Locate the http section and
modify it:

  - add a comment in front of the "include /etc/nginx/sites-enabled/\*;"
    line to disable it
  - add the following at the end of the http section:

<!-- end list -->

    upstream yacyappliance {
     ip_hash;
     server   localhost:8090;
     server   localhost:8091;
    }
    server {
     listen 8100;
     server_name yacy-appliance;
     location / {
      proxy_pass  http://yacyappliance;
      proxy_redirect off;
      proxy_set_header   Host             $host;
      proxy_set_header   X-Real-IP        $remote_addr;
      proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
      client_max_body_size       10m;
      client_body_buffer_size    128k;
      proxy_connect_timeout      3s;
      proxy_send_timeout         10s;
      proxy_read_timeout         10s;
      proxy_buffer_size          4k;
      proxy_buffers              4 32k;
      proxy_busy_buffers_size    64k;
      proxy_temp_file_write_size 64k;
     }
     location \.(jpg|png|gif|jpeg|css)$ {
      proxy_buffering on;
      proxy_cache_valid 200 120m;
      expires 864000;
     }
    }

This will run nginx at port 8100; if you want to run it at port 80 then
just replace the 8100 with 80. Finally run

    /etc/init.d/nginx restart

and open [http://{yourhost}:8100](http://%7Byourhost%7D:8100) to check
that nginx is running and successfully routes the access from 8100 to
either 8090 or 8091. You can also stop one of the yacy0 or yacy1 and the
search interface at [http://{yourhost}:8100](http://%7Byourhost%7D:8100)
will still be available.

## Add a Heartbeat Check for the YaCy Peers

There is a check-alive script which checks if a YaCy server responds on
the web interface and restarts the application if it does not respond.
This script can be called on a regular basis using a cronjob. As root,
edit /etc/crontab and add the following lines

``` 
 0 * * * * yacyappliance cd /home/yacyappliance/yacy0/bin && ./checkalive.sh
15 * * * * yacyappliance cd /home/yacyappliance/yacy1/bin && ./checkalive.sh
30 * * * * yacyappliance cd /home/yacyappliance/yacy0/bin && ./checkalive.sh
45 * * * * yacyappliance cd /home/yacyappliance/yacy1/bin && ./checkalive.sh
```

This will cause that twice an hour each peer is checked and restarted,
if needed. This means a maximum downtime of 15 minutes if *both* peers
fail.

## Test Indexing, Replication and Fail-Over Access

We must put some document data to check fail-over after a replication.
Open
[http://{yourhost}:8090/CrawlStartExpert\_p.html](http://%7Byourhost%7D:8090/CrawlStartExpert_p.html)
and start a web crawl. When the crawl has created some data in the
search index, first test that a search request succeeds at
[http://{yourhost}:8090/](http://%7Byourhost%7D:8090/)

Then call (as user yacyappliance)

    ~/yacy1/bin/indexrestore.sh `~/yacy0/bin/indexdump.sh`

This replicates the index from yacy0 to yacy1. You can now open
[http://{yourhost}:8091/](http://%7Byourhost%7D:8091/) and get the same
search result as before. During the replication process the index in
yacy0 is first unmounted and during this process the search inteface
does not respond on search requests. At that time the load balancer on
[http://{yourhost}:8100/](http://%7Byourhost%7D:8100/) should switch to
the second peer. When the dump is done, the index in the second peer
becomes unavailable during reading of the dump and the load balancer
should switch to the first peer again.

## Automatically do an Index Backup and Replication

We want to have an automated and combined backup, replicate and stale
backup cleaning process to ensure that the replication peer is always
updated to the index of the primary peer while keeping dumps as a
back-up for emergency cases.

For this, we create a backup-directory. As user yacyappliance do

    mkdir ~/indexbackup

to create a storage directory for the index backup dumps. Now you can
create a backup with

    mv `~/yacy0/bin/indexdump.sh` ~/indexbackup/

To create such a backup automatically once every day during night-time,
add the following line to /etc/crontab

``` 
 5 3 * * * yacyappliance cd /home/yacyappliance/ && mv `yacy0/bin/indexdump.sh` indexbackup/
```

Then, every night a 3:05h the index is dumped. This should not take more
than 25 minutes because the next checkalive ping happens at 3:30h
according to the heartbeat configuration.

We use the index dump generated in the backup process to feed the index
dump to the replication peer yacy1. This is done manually by calling

    ~/yacy1/bin/indexrestore.sh ~/indexbackup/`ls -1tr ~/indexbackup | tail -1`

and automatically using the following entry in /etc/crontab

    50 3 * * * yacyappliance cd /home/yacyappliance/ && yacy1/bin/indexrestore.sh indexbackup/`ls -1tr indexbackup | tail -1`

which will use the dump created 45 minutes before. Again this should not
take more than 25 minutes because the peer yacy1 gets the next heartbeat
ping at 4:15. Feel free to add more backup/replicate lines to the
crontab to get index backups from the primary peer to the replication
peer more frequently; i.e. add 6 hours three times to make an backup at
3:05h, 9:05h, 15:05h and 21:05h while doing a backup to the replication
peer at 3:50h, 9:50h, 15:50h and 21:50h.

Finally we need a clean-up process to removed stale backups. This can be
done with

    cd ~/indexbackup && find * -type f -mtime +7 -delete

to delete all backups which are older than seven days. To do this
automatically, put

    20 4 * * * yacyappliance cd /home/yacyappliance/indexbackup && find * -type f -mtime +7 -delete

into the crontab. This will delete the update ten minutes after the
replication happened. Please modify the crontab lines if you wish to do
backup and replication more/less often.

## Automatically Update Debian

This is optional but recommended to install all new debian updates
automatically. As user root edit the file `/etc/crontab` and add the
following line:

    20 3 * * * root apt-get update && apt-get -y upgrade

This will update your server every night at 3:20h automatically.

## Automatically Update to Latest Code Changes

This optional function will cause that the YaCy Search Appliance will
always be up-to-date to the latest YaCy code changes. As user
yacyappliance do:

    cd ~/yacy_deploy
    git pull --tags origin master && ant clean all dist && cd RELEASE
    ../../yacy0/stopYACY.sh && tar xfz `ls -1tr | tail -1` -C ../../yacy0 --strip-components=1 && ../../yacy0/startYACY.sh
    ../../yacy1/stopYACY.sh && tar xfz `ls -1tr | tail -1` -C ../../yacy1 --strip-components=1 && ../../yacy1/startYACY.sh

We can run this also automatically, twice a day in a 12 hour distance by
alternating the peers to prevent that a bad release destroys both peers
at the same time. To do this, we wrap the commands above in shell
scripts and call them from the crontab. As user yacyappliance create the
following files:

"update.sh"

    cd ~/yacy_deploy
    git pull --tags origin master
    ant clean all dist

"upgrade.sh"

    timeout 120s $1/stopYACY.sh
    $1/killYACY.sh
    rm -f $1/lib/*
    rm -Rf $1/htroot
    cd yacy_deploy/RELEASE/
    tar xfz `ls -1tr | tail -1` -C ../../$1 --strip-components=1
    ../../$1/startYACY.sh

Set the executable flag of update.sh and upgrade.sh. Then, in
/etc/crontab, add the following lines:

    30 4 * * * yacyappliance cd /home/yacyappliance/yacy_deploy && ./update.sh
    40 4 * * * yacyappliance cd /home/yacyappliance/yacy_deploy && ./upgrade.sh yacy0
    15 18 * * * yacyappliance cd /home/yacyappliance/yacy_deploy && ./update.sh
    25 18 * * * yacyappliance cd /home/yacyappliance/yacy_deploy && ./upgrade.sh yacy1

Finally we should clean up the generated releases the same way as we
delete old backup files. This can be done with

    cd ~/yacy_deploy/RELEASE && find * -type f -mtime +7 -delete

and as a cron job with

    20 8 * * * cd /home/yacyappliance/yacy_deploy/RELEASE && find * -type f -mtime +7 -delete

## Usage of this High Availability Configuration

The public search interface is at
[http://{yourhost}:8100](http://%7Byourhost%7D:8100) (or
[http://{yourhost}](http://%7Byourhost%7D) if you set the reverse proxy
port to 80). Thats the URL you propagate as the search interface. To
administrate the search interface, use the address
[http://{yourhost}:8090](http://%7Byourhost%7D:8090), or better:
[https://{yourhost}](https://%7Byourhost%7D) if you followed the
instructions in [YaCy Over HTTPS](../operation/yacyoverhttps.md).

Please note that [http://{yourhost}](http://%7Byourhost%7D) is the
gateway for the load balancer while
[https://{yourhost}](https://%7Byourhost%7D) is only the access point
for the yacy0-peer and administration tasks.

Every time you changed the search interface configuration (like a new
skin or different ranking), you must do a full (downtime) replication
using the script `~/replicate_all.sh` (shut down both peers before this)
but it would be easy to make this as a high-availability task (shut down
yacy0 first, tar the DATA dir, start up yacy0, shut down yacy1, extract
DATA to yacy1, start up yacy1). There is no need to do this for index
updates after you started a web crawl, because the index replication
process does that once a day automatically. You might want to do this
more often by adjusting the line in crontab.





_Converted from
<https://wiki.yacy.net/index.php?title=En:Debian_High_Availability>, may
be outdated_




