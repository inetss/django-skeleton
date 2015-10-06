# Introduction

This is a skeleton for Django projects, a replacement for `django-admin.py startproject`.

It features a carefully thought source code layout, Git awareness, and unobtrusive virtualenv integration.

# TL;DR HOWTO

* Clone this project
* Rename `src/project` and `src/project/app` accordingly (**NOTE:** for small projects `project` and `app` could be the same word)
* Update `INSTALLED_APPS`, `ROOT_URLCONF`, `WSGI_APPLICATION`, `SECRET_KEY` and emails section in `project.settings`
* Update `src/manage.py` (reference to `project.settings`)
* Update `src/project/urls.py` (reference to `project.app.urls`)
* Copy `src/project/settings_local.py.sample` to `settings_local.py` and setup accordingly
* Delete `README.md`
* *(optionally)* Run `bin/venv.sh install && bin/manage.sh migrate && bin/manage.sh runserver`

# Details

## Provided defaults

* `requirements.txt`
* Django project `project`
* Django application `project.app`
* `settings.py` template
* Initial urlpatterns, view, model, template and static files
* Command-line entrypoint `manage.py`
* WSGI entrypoint `project.wsgi.application`
* `var/` folder for dynamic data
* `.gitignore`
* support for `robots.txt` and similar top-level files

## Deployment-specific setup

`project.settings` should be commited to Git and keep settings that relate to the project and are common between different working environments (e.g. `INSTALLED_APPS`).

`project.settings_local` is intentionally *.gitignore*'d and should keep all settings that are local to the current working environment (e.g. `DATABASES`).

If setup for a specific environment (e.g. the live server) is to be tracked via Git, commit its settings into `project.settings_live` and create a symlink in that environment:

`ln -s settings_live.py src/project/settings_local.py`

## Local Python virtualenv

A helper script is provided that creates and maintains a virtualenv at `var/venv`.

Create or update the virtualenv:

`bin/venv.sh install`

Run a command within the virtualenv:

`bin/venv.sh pip freeze | grep blah`

Run `manage.py` within the virtualenv:

`bin/manage.sh migrate`

