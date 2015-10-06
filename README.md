# Introduction

This is a skeleton for Django projects, a replacement for `django-admin.py startproject`.

It features a carefully thought Django project source files layout, Git awareness, and unobtrusive virtualenv integration.

# TL;DR HOWTO

* Clone this project
* Rename `src/project` and `src/project/app` accordingly (**NOTE:** for small projects `project` and `app` could be the same word)
* Update `INSTALLED_APPS`, `ROOT_URLCONF`, `WSGI_APPLICATION` accordingly (also review other sections such as "Emails" and "Security")
* Update `src/manage.py` (reference to `project.settings`)
* Update `src/project/urls.py` (reference to `project.app.urls`)
* Copy `src/project/settings_local.py.sample` to `settings_local.py` and setup accordingly
* *(optionally)* Run `bin/venv.sh install && bin/manage.sh migrate && bin/manage.sh runserver`

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

## `settings.py` and `settings_local.py`

Django settings are split into two files, one of which is shared using Git and one isn't.

### Common settings

Settings that are common between different working environments (e.g. `INSTALLED_APPS` or `LOGIN_URL`) are placed at `project.settings` and are tracked normally using Git.

### Local settings

Settings that are local to the current working environment (e.g. `DATABASES` or `DEBUG`) are placed at `project.settings_local`, which is *.gitignore*'d. A sample local settings template is placed at `settings_local.py.sample` for reference.

### Tracking local settings for some environment using Git

If setup for a specific environment (e.g. the production server) is to be tracked using Git, commit its settings into `project.settings_live`. In the target environment, create a symlink:

`ln -s settings_live.py src/project/settings_local.py`

## Initial urlpatterns, view, model and templates

These are just some sane defaults to start with.

## Static files folder `static/`

The project static files go into `static/` and become available under [http://project.com/static/]()

For production deployment with nginx, run `manage.py collectstatic` and point `location /static/` to `.../project/var/static`.

## `robots.txt` and friends

All files directly placed in `static/` folder (not in subfolders) will be also accessible as [http://project.com/filename.ext]() (without the static prefix) with a special rule in `project.urls`. Typical uses are:

* `robots.txt`
* `favicon.ico`
* Third-party domain verification meta files

## Command-line entrypoint `manage.py`

Run:

`src/manage.py migrate` (requires a configured Python environment)

`bin/manage.sh migrate` (uses a bundled virtualenv integration, see below)

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

Create or update the virtualenv: `bin/venv.sh install` (uses `requirements.txt`)

Run arbitrary command within the virtualenv: `bin/venv.sh pip freeze | grep blah`

Run `manage.py` within the virtualenv: `bin/manage.sh migrate`

# TODO

* Provide defaults for AWS Elastic Beanstalk deployment
* Provide a sample Dockerfile
* Invent a way to convert this generic instructions to a project-specific layout instructions
