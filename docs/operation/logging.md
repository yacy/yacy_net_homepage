# Logging in YaCy

Every YaCy instance keeps a log of it's operation. 

To take a look into a log is useful for debugging, when hunting an error,
inefficiency or just for... train-spotting.

Seak peek into log is in the web UI `/ViewLog_p.html`.  You can filter the
entries based on regular-expression.  And as you know, a fragment of log is
shown live at the Status page (`/Status.html`).

## Logfiles

Real log is located in file `DATA/LOG/yacy00.log`. You can watch it live by
common unix tools like
[tail](https://www.man7.org/linux/man-pages/man1/tail.1.html).

`tail` has a parameter -F, which allows to monitor logfile live: 

	`tail -F DATA/LOG/yacy00.log`

You can use `grep` to filter out only lines you wanna see:

	`tail -F DATA/LOG/yacy00.log | grep CRAWLER`

or to hide the lines you don't want to read ('negative' grep):

	`tail -F DATA/LOG/yacy00.log | grep -v CRAWLER`

You can also use some colorizer like [ccze](https://github.com/cornet/ccze)
to increase the readability of logs.

Logs are rotated after filling, which can be very fast, last log is
`yacy00.log` and `tail`s parameter `-F` helps you to keep a track of actual
file.

Queries searched by your instance are logged anonymously in
`DATA/LOG/queries.log` with timestamps. Currently, there is a certain
delay after which entry appears in the queries.log.

## Verbosity

You can set the verbosity of logging in `DATA/LOG/yacy.logging` file, for
example when you hunt a bug or, on the other side, you want to unclutter the
logfile and show only information useful for you.

For each component of YaCy, eg. `CRAWLER`, `NETWORK`, etc. you can set a
level of details logged:
 
 - `OFF` - no output at all
 
 - `SEVERE` - system-level error, internal cause, critical and not fixable (i.e. inconsistency)
 
 - `WARNING` - uncritical service failure, may require user activity (i.e. input required, wrong authorization)
 
 - `INFO` - regular action information (i.e. any httpd request URL)
 
 - `CONFIG` - regular system status information (i.e. start-up messages)
 
 - `FINE` - in-function status debug output
 
 - `FINER` - more details in debug output
 
 - `FINEST` - even more details in debug output

For example `NETWORK.level = WARNING` set in `yacy.logging` will not show the regular p2p network
traffic, only the warnings, in the logs.

Technically,
[ConcurrentLog](https://yacy.net/api/javadoc/net/yacy/cora/util/ConcurrentLog.html)
class is used for logging in YaCy java source code.