changeHtaccessStyle
===================

Changes the Apache 2.2 htaccess style, to the new one from Apache 2.4

Changes the following old style htaccess file

<pre>
Order Allow,Deny
Deny from all
Allow from 111.222. 111.222.3
Allow from 127.0.0.1 test.com
Allow from 10.1.0.0/255.255.0.0 10.1.0.0/16

&lt;Directory /bla&gt;
Order Deny,Allow
Deny From All
Allow from localhost
&lt;/Directory&gt;

&lt;Directory /blabla&gt;
        Order Deny,Allow
  Deny From All
 Allow from localhost
&lt;/Directory&gt;

&lt;Directory /bladfsfs&gt;
Order Deny,Allow
Deny From 127.0.0.1 host.com
Allow from all
&lt;/Directory&gt;
</pre>

to the new style from Apache 2.4

<pre>
# Auskommentiert durch ./changeHtaccessStyle.pl Skript am 20.12.2012
# Order Allow,Deny
# Deny from all
Require all denied
# Allow from 111.222. 111.222.3
Require ip 111.222.
Require ip 111.222.3
# Allow from 127.0.0.1 test.com
Require ip 127.0.0.1
Require host test.com
# Allow from 10.1.0.0/255.255.0.0 10.1.0.0/16
Require ip 10.1.0.0/255.255.0.0
Require ip 10.1.0.0/16

&lt;Directory /bla&gt;
# Auskommentiert durch ./changeHtaccessStyle.pl Skript am 20.12.2012
# Order Deny,Allow
# Deny From All
Require all denied
# Allow from localhost
Require host localhost
&lt;/Directory&gt;

&lt;Directory /blabla&gt;
# Auskommentiert durch ./changeHtaccessStyle.pl Skript am 20.12.2012
# Order Deny,Allow
# Deny From All
Require all denied
# Allow from localhost
Require host localhost
&lt;/Directory&gt;

&lt;Directory /bladfsfs&gt;
# Auskommentiert durch ./changeHtaccessStyle.pl Skript am 20.12.2012
# Order Deny,Allow
# Deny From 127.0.0.1 host.com
# Allow from all
Require all granted
&lt;/Directory&gt;
</pre>
