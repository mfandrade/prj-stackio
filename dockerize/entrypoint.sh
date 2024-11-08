#!/bin/sh
PWFILE=/var/tmp/database.pw # set by compose.yaml
if [ ! -f $PWFILE ]; then
	echo "ERROR: database.pw file not found" >&2
	exit 1
else
	echo "dbuser:$(cat $PWFILE)@tcp(backend:3306)/db" >/etc/server.conf
fi
/bin/webserver
exit 0
