# Project structure

## Python requirements

`requirements.txt` is placed in the root project folder, like this:

```
Django==1.9.5
psycopg2==2.6.1
```

All libraries must be pinned to their specific versions.

## Python sources

All Python sources go into `src/` folder.

## Django settings

Django settings are split into two files:

* `settings.py` goes to Git
* `local_settings.py` is .gitignore'd.

### Environment-independent settings

Settings that are common between different working environments (e.g. `INSTALLED_APPS` or `LOGIN_URL`) go into `acme.settings`.

### Environment defaults

Defaults for settings that are local to the current working environment (e.g. `DATABASES` or `DEBUG`) are configured at the bottom of `acme.settings`.

### Environment overrides

Settings that needs to be overriden in a specific environment (e.g. `ALLOWED_HOSTS`) are placed at `acme.local_settings`, which is .gitignore'd.

A sample local settings template is placed at `local_settings.sample.py`.

### Sharing environment overrides

If setup for a specific environment (e.g. the production server) is to be shared via Git, commit its settings into `acme.production_settings`. On the production server, create a symlink:

```bash
cd src/acme
ln -s production_settings.py local_settings.py
```

If using Docker, this symlink can be created automatically with:

```bash
docker run -e DJANGO_LOCAL_SETTINGS=production_settings.py [...]
```

## Static files

`django.contrib.staticfiles` is enabled and expects project static files at `static/`. The files become available under <http://acme.com/static/>.

For production deployment, run `manage.py collectstatic` and add a rewrite rule pointing to `var/static`. With nginx, that would be:

```
location /static/ {
	alias /srv/acme/var/static;  # or "root /srv/acme/var;"
}
```

### `robots.txt` and friends

All files directly placed in `static/` folder (not in subfolders) will be also accessible as <http://acme.com/filename.ext> (i.e. without the static prefix) with a special rule in `acme.urls`. Typical uses are:

* `robots.txt`
* `favicon.ico`
* Third-party domain verification meta files

## Django CLI entrypoint

Run:

`src/manage.py shell` (requires a configured Python environment)

`./manage shell` (uses a bundled virtualenv integration, see below)

## WSGI entrypoint

Point your wsgi server to `acme.wsgi.application`

## Dynamic data folder `var/`

Everything under `var/` is .gitignore'd. Use it for:

* `var/static/` (`manage.py collectstatic` destination)
* `var/media/` (media files)
* `var/venv/` (bundled virtualenv)
* `var/log/`, `var/backup/`, `var/run/` and similar uses

## `.gitignore`

Please don't put your `.pydevproject` and `.idea` ignores here. Put them in your `~/.gitignore` instead.

## Local Python virtualenv

A helper script is provided that creates and maintains a virtualenv at `var/venv/`, which is handy for local developer environments.

* Create or update the virtualenv: `./manage install` (uses `requirements.txt`)
* Activate virtualenv and open shell: `./manage virtualenv`
* Activate virtualenv and run pip: `./manage pip freeze > requirements.txt`
* Activate virtualenv and run arbitrary command: `./manage virtualenv which python`
* Anything else activates virtualenv and runs `manage.py`: `./manage runserver 8888`
