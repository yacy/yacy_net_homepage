# YaCy and Solr Cloud


This is an advanced [Solr for YaCy](./solr.md)
installation which uses the SolrCloud architecture. If you want to read
and understand this, you should be (at least a little bit) familiar with
debian, Solr and tomcat.

In this example, we install a shard of 4 Solr instances within the same
server.



## Software Installation

We install tomcat, zookeeper and YaCy as standard debian packages and
Solr as web app for tomcat.

### Tomcat Installation

We will install tomcat as a standard debian system service using apt:

    apt-get install tomcat6 tomcat6-examples tomcat6-admin tomcat6-docs

The tomcat web service on port 8080 will start automatically and you can
open the default page at <http://localhost:8080> The optional packages
tomcat6-examples tomcat6-admin tomcat6-docs are great to develop and
test applications, but it is also possible to omit them. If you
installed the optional packages, then you can test them:

  - <http://localhost:8080/docs/> is the online-documentation
  - <http://localhost:8080/examples/> links to a set of example tomcat
    applications
  - <http://localhost:8080/manager/html> and
    <http://localhost:8080/host-manager/html> are tomcat management
    applications but their access is restricted. To use them you must
    set a password in /etc/tomcat6/tomcat-users.xml, like

<!-- end list -->

    <?xml version='1.0' encoding='utf-8'?>
    <tomcat-users>
       <role rolename="admin"/>
       <role rolename="admin-gui"/>
       <role rolename="manager"/>
       <role rolename="manager-gui"/>
       <user username="admin" password="tomcat" roles="admin,admin-gui,manager,manager-gui"/>
    </tomcat-users>

After setting this, you must restart tomcat with

    /etc/init.d/tomcat6 restart

and then you can log in the
[manager](http://localhost:8080/manager/html) and
[host-manager](http://localhost:8080/host-manager/html) servlet with
the user 'admin' and the password 'tomcat'. Please replace the default
password 'tomcat' with your own.

The relevant paths for the result of this installation are:

    tomcat users:     /etc/tomcat6/tomcat-users.xml
    CATALINA_HOME:    /usr/share/tomcat6
    CATALINA_BASE:    /var/lib/tomcat6
    default web page: /var/lib/tomcat6/webapps/ROOT/index.html

### Zookeeper Installation

The SolrCloud peers need a common configuration system which is provided
by zookeeper. Zookeeper can be installed with

    apt-get install zookeeper zookeeperd

This will create a new user named 'zookeeper'. The relevant paths are at

    Zookeeper config: /etc/zookeeper/conf (linked to /etc/zookeeper/conf_example)
    Zookeeper data:   /var/lib/zookeeper/
    Zookeeper binary: /usr/share/zookeeper/

To check if Zookeeper is running, start the Zookeeper shell:

    /usr/share/zookeeper/bin/zkCli.sh 

and run shell scripts like

    ls /
    ls /zookeeper

Because solr is started within tomcat and needs to know the host address
of zookeeper, we must assign this to tomcat as a jvm option. Open the
file /usr/share/tomcat6/bin/catalina.sh and add the following lines at
the begining of the document (right after the comments):

    # added zookeeper host information used by tomcat to find Solr shards for the SolrCloud
    CATALINA_OPTS=$CATALINA_OPTS -DzkHost=localhost:2181

..and restart tomcat

    /etc/init.d/tomcat6 restart

### Solr Installation

Download a solr release from <http://lucene.apache.org/solr/> (Solr
4.5.1. worked while Solr 4.6.0 did not work!) i.e.

    cd /opt
    wget http://apache.mirrors.spacedump.net/lucene/solr/4.5.1/solr-4.5.1.tgz
    tar xfz solr-4.5.1.tgz
    ln -s solr-4.5.1 solr
    ln -s solr-4.5.1/dist/solr-4.5.1.war solr.war

Because Solr uses a different logging in jetty as implemented in solr,
we must add slf4j adapters to the tomcat library

    cd /usr/share/tomcat6/lib/
    wget http://www.slf4j.org/dist/slf4j-1.6.6.zip
    apt-get install unzip
    unzip slf4j-1.6.6.zip 
    cp slf4j-1.6.6/{jcl-over-slf4j-1.6.6.jar,slf4j-1.6.6/log4j-over-slf4j-1.6.6.jar,slf4j-1.6.6/slf4j-api-1.6.6.jar,slf4j-1.6.6/slf4j-jdk14-1.6.6.jar} .

and restart tomcat:

    /etc/init.d/tomcat6 restart

### YaCy Installation

Follow the [YaCy for Debian installation
instructions](../installation/debianinstall.md)
and select 'webportal' as network to join into (we consider that you do
this not create a standalone-YaCy, not a peer-to-peer participant; you
can of course also use this for a 'freeworld' peer as well). The
relevant paths are at

    YaCy data:          /var/lib/yacy
    YaCy log:           /var/log/yacy
    YaCy binary:        /usr/share/yacy/
    Solr conf for YaCy: /usr/share/yacy/defaults/solr

## Software Configuration

The SolrCloud needs a common configuration of the index cores used by
YaCy. YaCy uses two cores, 'collection1' and 'webgraph'. Both are
defined with a generic index schema and they are exact clones of each
other. It may be also possible to defines these cores with non-generic,
exact defined schema.xml files, but we will not do that right now
because it makes things much more complex.

### Zookeeper Client for Solr

First, we need a Zookeeper client for Solr because Solr provides it's
own client app to upload the relevant configuration files. We must
fabricate this client using the libraries inside the Solr war-file and
additional libraries for logging. We use the already installed war file,
you must adopt the paths here if you used a more recent version of Solr:

    unzip -q /opt/solr.war -d /tmp/solr-war/
    mkdir /usr/share/zookeeper/solr-cli-lib
    cp /tmp/solr-war/WEB-INF/lib/* /usr/share/zookeeper/solr-cli-lib/ # solr libs
    cp /opt/solr/example/lib/ext/* /usr/share/zookeeper/solr-cli-lib/ # logger libs
    rm -Rf /tmp/solr-war

Now we can take advantage of the SolrCloud ZooKeeper CLI commands.

### Create Solr Configuration of Solr Cores for YaCy Inside Zookeeper

For a detailed description of the set-up of Solr Clusters and a
SolrCloud configuration, see the [SolrCloud Wiki of
apache.org](http://wiki.apache.org/solr/SolrCloud), the [SolrCloud
Installation in Tomcat](http://wiki.apache.org/solr/SolrCloudTomcat),
a [Guide to SolrCloud
Configuration](http://systemsarchitect.net/painless-guide-to-solr-cloud-configuration/)
and a [SolrCloud Cluster (Single Collection)
Deployment](http://myjeeva.com/solrcloud-cluster-single-collection-deployment.html).
To upload the solr configuration in Zookeeper, we fabricate a config
directory using the solr example config and the YaCy genric schema file
schema.xml:

    cp -R /opt/solr/example/solr/collection1/conf /opt/yacyconf
    cp /usr/share/yacy/defaults/solr/schema.xml /opt/yacyconf/

We can then use that to upload the configuration to zookeeper:

    java -classpath .:/usr/share/zookeeper/solr-cli-lib/* org.apache.solr.cloud.ZkCLI -zkhost localhost:2181 -cmd upconfig -confdir /opt/yacyconf -confname yacygeneric

That configuration is good for both collections, 'collection1' and
'webgraph'. We can link this configuration therefore to both
collections:

    java -classpath .:/usr/share/zookeeper/solr-cli-lib/* org.apache.solr.cloud.ZkCLI -zkhost localhost:2181 -cmd linkconfig -collection collection1 -confname yacygeneric
    java -classpath .:/usr/share/zookeeper/solr-cli-lib/* org.apache.solr.cloud.ZkCLI -zkhost localhost:2181 -cmd linkconfig -collection webgraph -confname yacygeneric

Lets see whats inside of zookeeper now, i.e. how the collection1 is
linked against the generic schema:

    /usr/share/zookeeper/bin/zkCli.sh get /collections/collection1

#### Create Tomcat Configuration of Solr Web Services

We want to use four Solr servers as a SolrCloud, each with two cores
('collection1' and 'webgraph'). We create subdirectories for the servers
inside of /var/opt/solrcloud/:

    mkdir /var/opt/solrcloud/
    mkdir /var/opt/solrcloud/solr0
    mkdir /var/opt/solrcloud/solr1
    mkdir /var/opt/solrcloud/solr2
    mkdir /var/opt/solrcloud/solr3

In each of these directories, put a file named solr.xml. The description
for the creation of that file in the web is mainly void, since there is
a new [xml structure for solr.xml for Solr 4.4 and
beyond](http://wiki.apache.org/solr/Solr.xml%204.4%20and%20beyond),
especially for [Core Discovery with
SolrCloud](http://wiki.apache.org/solr/Core%20Discovery%20%284.4%20and%20beyond%29).
Put the following content into `/var/opt/solrcloud/solr0/solr.xml`:

    <?xml version="1.0" encoding="UTF-8" ?>
    <solr>
      <int name="coreLoadThreads">4</int>
      <solrcloud>
        <str name="host">localhost</str>            
        <int name="hostPort">8080</int>             
        <str name="hostContext">solr0</str>         
        <str name="zkHost">localhost:2181</str>     
        <int name="zkClientTimeout">${solr.zkclienttimeout:30000}</int>
        <str name="shareSchema">${shareSchema:false}</str>
        <str name="genericCoreNodeNames">${genericCoreNodeNames:true}</str>
      </solrcloud>
      <shardHandlerFactory name="shardHandlerFactory" class="HttpShardHandlerFactory">
        <int name="socketTimeout">${socketTimeout:0}</int>
        <int name="connTimeout">${connTimeout:0}</int>
      </shardHandlerFactory>
    </solr>

Finally, make the path `/var/opt/solrcloud/` writable for tomcat6:

    chown -R tomcat6 /var/opt/solrcloud/
    chgrp -R tomcat6 /var/opt/solrcloud/

To deploy Solr with the YaCy configuration you must create a Tomcat
Context fragment for each Solr instance. A Tomcat Context Fragment is a
file in `/var/lib/tomcat6/conf/Catalina/localhost`. Therefore, we must
create four files, one for each Solr server, in this directory: write a
file to `/var/lib/tomcat6/conf/Catalina/localhost/solr0.xml` with the
following content:

    <?xml version="1.0" encoding="utf-8"?>
    <Context docBase="/opt/solr.war" debug="0" crossContext="true">
      <Environment name="solr/home" type="java.lang.String" value="/var/opt/solrcloud/solr0" override="true"/>
    </Context>

and copy this to `solr1.xml .. solr3.xml` and patch the solr/home
attribute to `solr1 .. solr3`. If you patch these files using emacs, make
sure that you delete all files ending with '~' because they will cause
an error. Finally, restart tomcat:

    /etc/init.d/tomcat6 restart

### Create the SolrCloud

We can now open the Solr web service at <http://localhost:8080/solr0>
Open this web page to check if the service is up and running. Then we
can use that web service to instantiate the SolrCloud:

    curl 'http://localhost:8080/solr0/admin/collections?action=CREATE&name=collection1&numShards=4&replicationFactor=1'
    curl 'http://localhost:8080/solr0/admin/collections?action=CREATE&name=webgraph&numShards=4&replicationFactor=1'

### Assign the SolrCloud to YaCy

When the SolrCloud is ready and running, it can be assigned to YaCy as
storage server. Open the servlet at
<http://localhost:8090/IndexFederated_p.html> and select the flag "Use
remote Solr server(s)". As server address, enter one of the Solr
servers, like <http://192.168.4.10:8080/solr0> Finally, uncheck the flag
"Use deep-embedded local Solr".





_Converted from
<https://wiki.yacy.net/index.php?title=Dev:SolrCloud>, may be outdated_




