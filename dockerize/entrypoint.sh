#!/bin/sh
if [ -z "$MARIADB_PASSWORD" ]; then
    echo "ERROR: MARIADB_PASSWORD not defined" >/dev/stderr
    exit 1
fi
CONF=/srv/app/server.conf

PASS=$MARIADB_PASSWORD
PASS_=$(printf '%s\n' "$PASS" | sed 's/:/%3A/g; s/\//%2F/g') # URL encode
echo "dbuser:$PASS_@tcp(backend:3306)/db" >"$CONF"

EXEC="${1:-/bin/sh}"

if [ ! -x "$EXEC" ]; then
    echo "ERROR: $EXEC binary not found" >/dev/stderr
    exit 2
fi

"$EXEC"
