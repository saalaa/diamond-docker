#!/bin/sh -e

tcp_wait ()
{
  echo "Waiting for $1:$2"

  while ! nc -z "$1" "$2"; do
    sleep 0.5
  done
}

tcp_wait redis 6379
tcp_wait postgresql 5432

case "$1" in

  web|worker)
    if [ "$1" = "web" ]; then
      echo "Applying migrations"

      scripts/diamond.sh db upgrade
    fi

    echo "Running $1"

    exec scripts/$1.sh
    ;;

  *)
    exit 1
    ;;

esac
