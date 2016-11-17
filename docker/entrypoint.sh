#!/bin/bash

set -e

mkdir -p var/{static,media}
find var -type d -not -perm 755 -exec chmod 755 {} \; -exec chmod -s {} \;
find var -type f -not -perm 644 -exec chmod 644 {} \;
chown -R app:nogroup var

s=src/acme/local_settings.py
if [ ! -e "$s" ]; then
	ln -sf "${DJANGO_LOCAL_SETTINGS:-docker_settings.py}" "$s"
fi

sudo -u app -E src/manage.py migrate --noinput
sudo -u app -E src/manage.py collectstatic --link --noinput --verbosity 0

supervisord -c /etc/supervisord.conf --nodaemon
