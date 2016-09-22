# Introduction

This is a skeleton for Django projects, sort of a replacement for `django-admin.py startproject`

Features:

* Django 1.9 with Python 3.5
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
* [Initial project documentation](docs-i18n/en/README.md)

# How to use

## Step 1: Clone this project

```bash
git clone git@github.com:iteratia/django-skeleton.git acme
cd acme
rm -rf .git
cp src/acme/local_settings.sample.py src/acme/local_settings.py
```

## Step 2: Run the local development server...

```bash
./manage install
./manage makemigrations app
./manage migrate
./manage runserver
```

Then open <http://localhost:8000>

### ...or, run inside Docker

```bash
./manage install
./manage makemigrations app
docker build -t app .
docker run -d --name app-postgres -e POSTGRES_PASSWORD=secret postgres
docker run --rm -it --name app --link app-postgres:postgres -e DJANGO_DEBUG=1 -v $(pwd)/var/media:/app/var/media -p 8000:80 app
```

Then open <http://localhost:8000>

## Step 3: Rename default project and app

The default Python package is named `acme` and the default Django app is named `acme.app`. To rename them, run:

```bash
./rename_project_app.sh myproject myapp
```

**WARNING: The script is broken at the moment, please rename manually.**

For smaller projects, `myproject` and `myapp` could often be the same word.

## Step 4: Remove skeleton files

```bash
rm rename_project_app.sh
mv docs-i18n/en/* . && rm -rf docs-i18n/
```
