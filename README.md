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
* [Initial project documentation](docs-template/en/README.md)

# How to use

## Step 1: Clone this project

```bash
git clone git@github.com:iteratia/django-skeleton.git acme
cd acme
rm -rf .git
```

## Step 2: Run the local development server...

```bash
cp src/acme/local_settings.sample.py src/acme/local_settings.py
./manage install
./manage migrate
./manage runserver
```

Then open <http://localhost:8000>

### ...or, run the production version inside Docker

```bash
docker-compose up
```

Then open <http://localhost:8000>

## Step 3: Rename default project and app

The default Python package is named `acme` and the default Django app is named `acme.app`. Please rename them accordingly:

```bash
# TODO: add the actual find|sed commands here
```

For smaller projects, `myproject` and `myapp` could often be the same word.

## Step 4: Put the project documentation template instead of this README

```bash
mv docs-template/en/* . && rm -rf docs-*/
```
