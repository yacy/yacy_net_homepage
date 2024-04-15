# Solr and YaCy Integration

Hint: If you are not a developer, just don't care about this topic. Solr
is already inside YaCy, just do nothing.

YaCy uses Solr (and other data structures) to store the local search
index (while the remote search index is a RWI data structure). The Solr
index is deeply/programmatically embedded into YaCy, but it is also
possible to use an external Solr index which can then be assigned to
YaCy as external storage. This can be activated with one single click if
you have a running Solr, configured for YaCy.

The remote index scheme is similar (but extended) to SolrCell; see
<http://wiki.apache.org/solr/ExtractingRequestHandler> We added some
more generic fields, added a second solr core and therefore we need to
use the solr.xml and schema.xml from a YaCy installation.

## Use the deep-embedded Solr in YaCy and an external Solr concurrently

This is the default setting. The assignment of a remote Solr and also
switching off of the embedded Solr is done in the servlet
/IndexFederated_p.html. The embedded Solr is switched on, if the flag
"Use deep-embedded local Solr" is switched on.

## Use an external Solr or Solr Shards to have a distributed Solr-backend for a single YaCy

In the "Solr URL(s)" field of the
<http://localhost:8090/IndexFederated_p.html> servlet, you can enter
several Solr addresses. If there is more than one Solr assigned, these
are accessed as a 'Shard'. This will cause that each document is hashed
using the document id and stored only in one of the shards. If a query
to Solr is made, then all shards are queried concurrently and the
results are merged.

## Concurrent usage of the embedded Solr and an external Solr or Solr Shard

It is possible to leave the "Use deep-embedded local Solr" flag switched
on while using an external Solr. Then each document is stored in the
local and the remote Solr. If a document is searched, this is done
concurrently in the local and remote Solr as if they are a Solr Shard.

# How to deploy an external Solr for YaCy

The deployment needs two steps: (1) embedd Solr into a servlet
environment, (2) configure Solr for YaCy. Both is described in each of
the following three options: you can choose between Jetty and Tomcat as
servlet container, do only one of the following three:

## Use the example-deployment in a Solr package

This is probably the easiest and fastest way to test a YaCy-Solr
connection. Don't do this for a production environment; one of the next
two options is better for this. The following steps uses Solr 4.1.0; you
can use the most recent version as well.

  - Download solr-4.1.0.tgz from <http://lucene.apache.org/solr/>
  - Decompress solr-4.1.0.tgz (with 'tar xfz solr-4.1.0.tgz') and put
    solr-4.1.0 into ~/
  - We must defined two cores for Solr: the default collection1 and an
    addition 'webgraph' core. This is done by copying the YaCy solr.xml

<!-- end list -->

    cp ~/yacy/defaults/solr/solr.xml ~/solr-4.1.0/example/solr/collection1/conf/

  - The webgraph core is basically a copy of the default collection1
    core. Create a configuration for the webgraph as a clone of
    collection1:

<!-- end list -->

    mkdir ~/solr-4.1.0/example/solr/webgraph
    cp -R ~/solr-4.1.0/example/solr/collection1/conf ~/solr-4.1.0/example/solr/webgraph/conf

  - A YaCy schema configuration must be copied to each core. To do this,
    we have two options: either copy a generic version of the schema.xml
    as used by YaCy

<!-- end list -->

    cp ~/yacy/defaults/solr/schema.xml ~/solr-4.1.0/example/solr/collection1/conf/
    cp ~/yacy/defaults/solr/schema.xml ~/solr-4.1.0/example/solr/webgraph/conf/

or, using the explicit schema definition which can be extracted from the
YaCy API; start YaCy (if not already running) and execute the following
commands:

    ~/yacy/bin/apicat.sh /api/schema.xml?core=collection1 > ~/solr-4.1.0/example/solr/collection1/conf/schema.xml
    ~/yacy/bin/apicat.sh /api/schema.xml?core=webgraph > ~/solr-4.1.0/example/solr/webgraph/conf/schema.xml

  - Finally, start the external Solr with:

<!-- end list -->

    cd ~/solr-4.1.0/example/ && java -jar start.jar

Solr is then running at <http://127.0.0.1:8983/solr>

  - Start YaCy (if not already running) and open
    <http://localhost:8090/IndexFederated_p.html>
  - in the "Solr URL(s)" field, enter: <http://127.0.0.1:8983/solr> (or
    a remote address, if you want to run solr on a different server)
  - uncheck the "Use deep-embedded local Solr" flag and check the "Use
    remote Solr server(s)" flag

## Deploy Solr in Tomcat

First you must download and decompress tomcat 6. In this example you
install tomcat to your home directory at `~/tomcat/`

    cd ~
    wget http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.37/bin/apache-tomcat-6.0.37.tar.gz
    tar xfz apache-tomcat-6.0.37.tar.gz
    mv apache-tomcat-6.0.37 tomcat

To deploy a solr container, download a solr package and copy the
relevant files to the correct tomcat subdirectory:

    cd ~/tomcat
    wget http://www.eu.apache.org/dist/lucene/solr/4.5.1/solr-4.5.1.tgz
    tar xfz solr-4.5.1.tgz
    cp solr-4.5.1/dist/solr-4.5.1.war .
    cp -R solr-4.5.1/example/solr yacyindex

We need to copy the YaCy schema and the definition of the second core
'webgraph'. Consider that at ~/yacy you have installed a YaCy peer,
then you can simply copy the generic schema file for collection1 to
solr:

    cp ~/yacy/defaults/solr/schema.xml ~/tomcat/yacyindex/collection1/conf/

Clone the collection1 to get the webgraph core

    cp -R ~/tomcat/yacyindex/collection1 ~/tomcat/yacyindex/webgraph

Patch the core.properties in
`~/tomcat/yacyindex/webgraph/core.properties` and replace the line
`name=collection1` with `name=webgraph`. Then copy the solr.xml
definition for two cores:

    cp ~/yacy/defaults/solr/solr.xml ~/tomcat/yacyindex/

Copy the solr logging libraries to the tomcat library folder because
Solr uses a different logging in jetty as implemented in solr. In the
~/tomcat directory, do

    cp solr-4.5.1/example/lib/ext/* ~/tomcat/lib/

To deploy Solr with the YaCy configuration you must create a Tomcat
Context fragment. This is a file within the conf subdirecty which is
created once tomcat was started. Therefore we start tomcat now:

    ~/tomcat/bin/startup.sh

Look at the path `~/tomcat/conf/Catalina/localhost` which was now
created. Thats the place where we create the Tomcat Context fragment.
You need the absolute path to the tomcat installation directory which we
consider as `/home/administrator/tomcat` in this example. Create a file in
`/home/administrator/tomcat/conf/Catalina/localhost/solr4yacy.xml` with
the following content:

    <?xml version="1.0" encoding="utf-8"?>
    <Context docBase="/home/administrator/tomcat/solr-4.5.1.war" debug="0" crossContext="true">
      <Environment name="solr/home" type="java.lang.String" value="/home/administrator/tomcat/yacyindex" override="true"/>
    </Context>

Restart tomcat to activate this configuration

    ~/tomcat/bin/shutdown.sh && ~/tomcat/bin/startup.sh

Finished! You can now access Solr with the url
<http://localhost:8080/solr4yacy/> This is the url which you can set in
the "Use remote Solr server(s)" field of the /IndexFederated_p.html
servlet in YaCy to attach the solr-in-tomcat to YaCy as remote storage
server. When doing this you may want to remove the flag "Use
deep-embedded local Solr" so this remote solr becomes the single storage
point for the YaCy search index.

### User Administration and Search Index Access Protection

Tomcat can add a password protection to web pages. There is i.e. a
default manager web application available at
<http://localhost:8080/manager/html> which cannot be accessed without
setting a role and a user name for this. We will activate the manager to
test the password protection: write the new role "manager" to the file
`~/tomcat/conf/tomcat-users.xml` and set a password, i.e.

    <?xml version='1.0' encoding='utf-8'?>
    <tomcat-users>
      <role rolename="manager"/>
      <user username="admin" password="tomcat" roles="manager"/>
    </tomcat-users>

Re-start tomcat, then open <http://localhost:8080/manager/html> and
manage solr applications there. Log-in with the user name 'admin' and
the password 'tomcat'. We will use this now to access our YaCy search
index in Solr. To do this, we need access rules defined in the web.xml
configuration file to declare a role to be protected. We will call this
role 'user' and the paths to be all paths within tomcat. Open the file
`~/tomcat/conf/web.xml` and add the following lines at the end before the
closing tag \</web-app\>:

    <security-constraint>
        <web-resource-collection>
            <url-pattern>/*</url-pattern>
        </web-resource-collection>
        <auth-constraint>
            <role-name>user</role-name>
        </auth-constraint>
    </security-constraint>
    <login-config>
        <auth-method>BASIC</auth-method>
        <realm-name>tomcat</realm-name>
    </login-config>
    <security-role>
        <role-name>user</role-name>
    </security-role>

To use the new role 'user', we add an account in the file
`~/tomcat/conf/tomcat-users.xml`. Add the following lines to
\<tomcat-users\>:

``` 
  <role rolename="user"/>
  <user username="yacyadmin" password="yacy123" roles="user"/>
```

and restart tomcat. You can now access Solr with the url
<http://yacyadmin:yacy123@localhost:8080/solr4yacy/> This is the url
which you can set in the "Use remote Solr server(s)" field of the
/IndexFederated_p.html servlet in YaCy. The account:password encoding
in the url is used by YaCy to access the solr index within tomcat.

# Copy the deeply-embedded Solr Index to an external Solr

This is easy, just copy the Solr directory in
DATA/INDEX/\<network\>/SEGMENTS/solr\_40 into the solr data directory of
your remote Solr installation. You can also do this using a script
during runtime. Call

    ~/yacy/bin/indexdump.sh

which causes that YaCy creates a tar.gz file of the `solr_40` directory
during runtime and the indexdump.sh script returns the file path to this
tar.gz file. This filename can then be processed further with your own
copy-and-deploy script to fill a remote Solr with that.



For cluster solr usage, see [Solr Cloud instructions](./solrcloud.md)


_Converted from
<https://wiki.yacy.net/index.php?title=Dev:Solr>, may be outdated_




