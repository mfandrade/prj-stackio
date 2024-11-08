#!/bin/sh
PW=/var/tmp/database.pw
CONF=/srv/app/server.conf

if [ ! -f "$PW" ]; then
  echo "ERROR: database.pw file not found" >/dev/stderr
  exit 1
fi

PASS=$(cat "$PW")
PASS_=$(printf '%s\n' "$PASS" | sed 's/:/%3A/g; s/\//%2F/g')
echo "dbuser:$PASS_@tcp(backend:3306)/db" >"$CONF"

EXEC="${1:-/bin/sh}"

if [ ! -x "$EXEC" ]; then
  echo "ERROR: $EXEC binary not found" >/dev/stderr
  exit 2
fi

"$EXEC"
