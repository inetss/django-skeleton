# Introduction

This is a skeleton for Django projects, sort of a replacement for `django-admin.py startproject`

Features:

* Django 1.9, Python 3
* 3 tiers of settings:
	* Environment-independent
	* Environment defaults (tracked via Git)
	* Environment overrides (outside of Git)
* Static and media files setup
* Handling `/robots.txt` and similar files
* WSGI entrypoint
* Virtualenv helper
* Dockerfile
* Dokku compatible
* Gitlab CI config

# TL;DR HOWTO

```sh
git clone git@github.com:iteratia/django-skeleton.git acme
cd acme
rm -rf .git
cp src/acme/local_settings.sample.py src/acme/local_settings.py
```

## Run the local development server...

```sh
./manage install
./manage makemigrations app
./manage migrate
./manage runserver
```

Then open <http://localhost:8000>

## ...or, run inside Docker

```
$ ./manage install
$ ./manage makemigrations app
$ docker build -t app .
$ docker run -d --name app-postgres -e POSTGRES_PASSWORD=secret postgres
$ docker run --rm -it --name app --link app-postgres:postgres -e DJANGO_DEBUG=1 -v $(pwd)/var/media:/app/var/media -p 8000:80 app
```

Then open <http://localhost:8000>

# Project structure

## `/requirements.txt`

`requirements.txt` is placed in the root project folder, like this:

```
Django==1.9.5
psycopg2==2.6.1
```

## Python sources folder `src/`

All Python sources go into `src/` folder.

## `settings.py` and `local_settings.py`

Django settings are split into two files, one of which is shared using Git and one isn't.

### Environment-independent settings

Settings that are common between different working environments (e.g. `INSTALLED_APPS` or `LOGIN_URL`) go into `acme.settings`.

### Environment defaults

Defaults for settings that are local to the current working environment (e.g. `DATABASES` or `DEBUG`) are configured at the bottom of `acme.settings`.

### Environment overrides

Settings that needs to be overriden in specific environment (e.g. `ALLOWED_HOSTS`) are placed at `acme.local_settings`, which is *.gitignore*'d.

A sample local settings template is placed at `local_settings.py.sample` for using in developer copies.

### Sharing environment overrides

If setup for a specific environment (e.g. the production server) is to be shared via Git, commit its settings into `acme.production_settings`. On the production server, create a symlink:

```bash
cd src/acme
ln -s production_settings.py local_settings.py
```

If using Docker, this symlink can be created automatically with:

```bash
docker run -e DJANGO_LOCAL_SETTINGS_FILE=production_settings.py [...]
```

## Static files folder `static/`

`django.contrib.staticfiles` is enabled and expects project static files at `static/`. The files become available under <http://acme.com/static/>

For production deployment, run `manage.py collectstatic` and add a rewrite rule pointing to `var/static`. With nginx, that would be:

```
location /static/ {
	alias /srv/acme/var/static; # or "root /srv/acme/var;"
}
```

### `robots.txt` and friends

All files directly placed in `static/` folder (not in subfolders) will be also accessible as <http://acme.com/filename.ext> (i.e. without the static prefix) with a special rule in `acme.urls`. Typical uses are:

* `robots.txt`
* `favicon.ico`
* Third-party domain verification meta files

## Django CLI entrypoint

Run:

`src/manage.py migrate` (requires a configured Python environment)

`./manage migrate` (uses a bundled virtualenv integration, see below)

## WSGI entrypoint

Point your wsgi server to `acme.wsgi.application`

## Dynamic data folder `var/`

Everything under `var/` is *.gitignore*'d. Use it for:

* `var/static/` (`manage.py collectstatic` destination)
* `var/media/` (media files)
* `var/venv/` (bundled virtualenv)
* `var/log/`, `var/backup/`, `var/run/` and similar uses

## `.gitignore`

Please don't put your `.pydevproject` and `.idea` ignores here. Put them in your `~/.gitignore` instead.

## Local Python virtualenv

A helper script is provided that creates and maintains a virtualenv at `var/venv/`, which is handy for developer environments.

* Create or update the virtualenv: `./manage install` (uses `requirements.txt`)
* Activate virtualenv and open shell: `./manage virtualenv`
* Activate virtualenv and run arbitrary command: `./manage virtualenv pip install foo`
* Anything else activates virtualenv and runs `manage.py`: `./manage runserver 8888`

# TODO

* Provide defaults for AWS Elastic Beanstalk deployment
* Split this README into:
	1. Skeleton description (the intro part).
	2. A document to be included with every project (the project structure part).
