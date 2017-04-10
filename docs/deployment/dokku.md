# Deployment to Dokku platform

The following guide assumes that the [official command line client](http://dokku.viewdocs.io/dokku/community/clients/#bash-zsh-etc-dokku_clientsh) `dokku` is installed at the operator's machine.

## Run Dokku app

In a local operator copy:

```bash
DOKKU_HOST=dokku.me dokku apps:create acme
dokku postgres:create acme
dokku postgres:connect acme < acme.backup.sql
dokku postgres:link acme acme
dokku storage:mount /srv/acme/media:/app/var/media
dokku config:set SECRET_KEY=$(pwgen -s 50 -n 1)
dokku config:set $(cat dokku.env)
git push dokku master
dokku domains:set acme.com www.acme.com
dokku redirect:set acme www.acme.com acme.com
dokku letsencrypt acme
```

The project is now accessible at <https://acme.com>.

## Update Dokku app

**ATTENTION: Normally, the app is updated automatically! See [Deployment workflow](workflow.md) for details. Please only use this for testing or debugging.**

In a local operator copy:

```bash
git push dokku@dokku.me:acme HEAD:master --force
```

This pushes the current local branch to Dokku.
