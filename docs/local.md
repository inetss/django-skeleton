# Setup local developer copy

## Install prerequisites

### OS X

[Install Homebrew](http://brew.sh/) if you haven't already, then run:

```bash
brew update
brew install postgres python3
brew services start postgres
pip install --upgrade pip
pip install virtualenv
```

### Ubuntu

```bash
apt-get update && apt-get install -y postgresql python3 python3-virtualenv
```

## Create PostgreSQL database

```bash
createdb project
```

## Copy project

```bash
git clone git@github.com:team/project.git project
cd project
```

## Setup local config

```bash
cp src/project/local_settings.sample.py src/project/local_settings.py
```

Review `local_settings.py`:

* add [database settings](https://docs.djangoproject.com/en/1.9/ref/settings/#databases) if needed

## Update local project dependencies

```bash
./manage install
bower install
```

This will need to be re-run every time a new dependency is added.

## Update database schema

```
./manage migrate
```

This will need to be re-run every time a new schema migration is added.

## Create local admin user

```
./manage createsuperuser
```

This only needs to run once.

## Run local server

```
./manage runserver
```

The project is now accessible at <http://localhost:8000>
