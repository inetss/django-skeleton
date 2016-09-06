# Dokku integration

The project is installed on Dokku platform.

The following guide assumes that the [official command line client](http://dokku.viewdocs.io/dokku/community/clients/#bash-zsh-etc-dokku_clientsh) `dokku` is installed at the operator's machine.

## Initial setup

In a local operator copy:

```bash
DOKKU_HOST=dokku.me dokku apps:create project
dokku postgres:create project
dokku postgres:connect project < project.backup.sql
dokku postgres:link project project
dokku config:set SECRET_KEY=$(pwgen -s 50 -n 1)
dokku storage:mount /var/lib/dokku/data/storage/project/media:/app/var/media
dokku config:set \
	ALLOWED_HOSTS=project.com \
	SENTRY_DSN=https://xxx:yyy@sentry.com/12345
git push dokku master
dokku domains:add project.com www.project.com
dokku redirect:set project www.project.com project.com
dokku letsencrypt project
```

The project is now accessible at <https://project.com>

## Update production site

**PLEASE NOTE:** You don't normally need to update the production site manually, as Gitlab CI does that automatically on every Git push.

In a local operator copy:

```bash
git push dokku@dokku.me:project HEAD:master --force
```

This pushes the current local branch to Dokku.
