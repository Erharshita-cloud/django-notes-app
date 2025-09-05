#!/bin/sh
host="$1"
shift
port="$1"
shift

until nc -z "$host" "$port"; do
  echo "Waiting for DB at $host:$port..."
  sleep 2
done

exec "$@"
