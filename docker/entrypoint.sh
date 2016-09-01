#!/bin/bash

set -e

for d in var/static var/media; do
	mkdir -p $d
	find $d -type d -not -perm 755 -exec chmod 755 {} \; -exec chmod -s {} \;
	find $d -type f -not -perm 644 -exec chmod 644 {} \;
	chown -R app:nogroup $d
done

if [ ! -e src/project/local_settings.py ]; then
	ln -s ${DJANGO_LOCAL_SETTINGS:-docker_settings.py} src/project/local_settings.py
fi

sudo -u app -E src/manage.py migrate --noinput
sudo -u app -E src/manage.py collectstatic --link --noinput --verbosity 0

supervisord -c /etc/supervisord.conf --nodaemon
