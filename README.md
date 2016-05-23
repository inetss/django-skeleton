# Introduction

This is a skeleton for Django projects, a replacement for `django-admin.py startproject`

Features:

* Django 1.9, Python 2/3
* Single-command virtualenv helper
* Git awareness
* Environment-local settings
* Static and media files setup
* Handling `/robots.txt`
* Django and Jinja2 templates
* WSGI entrypoint

# TL;DR HOWTO

```sh
git clone git@github.com:iteratia/django-skeleton.git myproject
cd myproject
rm -rf .git
cd src/project
cp local_settings.sample.py local_settings.py
```

Adjust configs:

* `src/project/settings.py`: update "Emails" and "Security" chapters
* `src/project/local_settings.py`: update local database DSN

Run the development server:

```sh
./manage install
./manage makemigrations myapp
./manage migrate
./manage runserver
```

## Rename `project` and `app`

The default Python package is named `project` and the default Django app is named `app`. To rename them, run:

```sh
./rename_project_app.sh myproject myapp
```

For smaller projects, `myproject` and `myapp` could often be the same word.

# Provided elements

## `/requirements.txt`

`requirements.txt` is placed in the root project folder. In particular, this allows direct AWS Elastic Beanstalk deployment.

Keep specific library versions, such as `Django==1.8.4` and **not** `Django` or `Django<=1.9`. This **will** save you time in future.

## Python sources folder `src/`

All Python sources go into `src/` folder.

## Sample Django project `project`

A sample Django project `project` is provided at `src/project/`, please rename it according to the actual project.

## Sample Django application `project.app`

A sample Django project `project.app` is provided, please rename it accordingly.

Keep the other project applications inside the project module, and not as top-level modules. `myproject.accounts` is good, `accounts` is a no-no.

## `settings.py` and `local_settings.py`

Django settings are split into two files, one of which is shared using Git and one isn't.

### Common settings

Settings that are common between different working environments (e.g. `INSTALLED_APPS` or `LOGIN_URL`) are placed at `project.settings` and are tracked normally using Git.

### Local settings

Settings that are local to the current working environment (e.g. `DATABASES` or `DEBUG`) are placed at `project.local_settings`, which is *.gitignore*'d. A sample local settings template is placed at `local_settings.py.sample` for reference.

### Tracking local settings for some environment using Git

If setup for a specific environment (e.g. the production server) is to be tracked using Git, commit its settings into `project.live_settings`. In the target environment, create a symlink:

`ln -s live_settings.py src/project/local_settings.py`

## Initial urlpatterns, model and view

These are just some sane defaults to start with.

## Django and Jinja2 templates

You can put your Django templates into `templates/` and Jinja2 templates into `jinja2/`. If you don't need Jinja2, you can get remove the references in `project.settings.TEMPLATES` and `requirements.txt`, and delete `src/project/jinja2.py`

## Static files folder `static/`

`django.contrib.staticfiles` is enabled and expects project static files at `static/`. The files become available under [http://project.com/static/]()

For production deployment, run `manage.py collectstatic` and add a rewrite rule pointing to `var/static`. With nginx, that would be:

```
location /static/ {
	alias /srv/project/var/static; # or "root /srv/project/var;"
}
```

### `robots.txt` and friends

All files directly placed in `static/` folder (not in subfolders) will be also accessible as [http://project.com/filename.ext]() (without the static prefix) with a special rule in `project.urls`. Typical uses are:

* `robots.txt`
* `favicon.ico`
* Third-party domain verification meta files

## Command-line entrypoint `manage.py`

Run:

`src/manage.py migrate` (requires a configured Python environment)

`./manage migrate` (uses a bundled virtualenv integration, see below)

Provide correct `DJANGO_SETTINGS_MODULE` environment variable and/or update the hardcoded default in `src/manage.py`.

## WSGI entrypoint `project.wsgi.application`

Provide correct `DJANGO_SETTINGS_MODULE` environment variable and/or update the hardcoded default in `src/manage.py`.

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
* Provide a sample Dockerfile
* Invent a way to convert this generic instructions to a project-specific layout instructions
