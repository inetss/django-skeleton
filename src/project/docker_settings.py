import os

from .settings import INSTALLED_APPS

DATABASES = {
	'default': {
		'ENGINE': 'django.db.backends.postgresql_psycopg2',
		'HOST': 'postgres',
		'USER': os.getenv('POSTGRES_USER') or os.getenv('POSTGRES_USERNAME') or 'postgres',
		'PASSWORD': os.getenv('POSTGRES_PASSWORD') or os.getenv('POSTGRES_PASS') or os.getenv('POSTGRES_ENV_POSTGRES_PASSWORD'),
		'NAME': os.getenv('POSTGRES_DATABASE') or os.getenv('POSTGRES_DB'),
	},
}

ALLOWED_HOSTS = list(filter(None, os.getenv('DJANGO_ALLOWED_HOSTS', '').split(',')))

DEBUG = bool(os.getenv('DJANGO_DEBUG'))

SENTRY_DSN = os.getenv('SENTRY_DSN')
if SENTRY_DSN:
	RAVEN_CONFIG = {'dsn': SENTRY_DSN}
	INSTALLED_APPS = list(INSTALLED_APPS) + ['raven.contrib.django.raven_compat']
