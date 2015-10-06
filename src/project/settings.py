import os

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


# Application definition

INSTALLED_APPS = (
	# Rules for this list:
	# - Group apps by module
	# - Sort groups by time (recently added go last)
	# - Sort apps within a group alphabetically
	# - If you need to place an app out of order, leave a comment explaining the reason why.
	'django.contrib.admin',
	'django.contrib.auth',
	'django.contrib.contenttypes',
	'django.contrib.sessions',
	'django.contrib.staticfiles',
	'project.app',
)

MIDDLEWARE_CLASSES = (
	# Same rules as above, mostly. Django middleware go in default order.
	'django.contrib.sessions.middleware.SessionMiddleware',
	'django.middleware.common.CommonMiddleware',
	'django.middleware.csrf.CsrfViewMiddleware',
	'django.contrib.auth.middleware.AuthenticationMiddleware',
	'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
	'django.contrib.messages.middleware.MessageMiddleware',
	'django.middleware.clickjacking.XFrameOptionsMiddleware',
	'django.middleware.security.SecurityMiddleware',
)

ROOT_URLCONF = 'project.urls'

WSGI_APPLICATION = 'project.wsgi.application'


# Internationalization
# https://docs.djangoproject.com/en/1.8/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'America/New_York'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Security

SECRET_KEY = '-change me-'  # generate a random key with 'pwgen -s 50 -n 1'


# Templates

TEMPLATE_DIRS = os.path.join(PROJECT_DIR, 'templates'),


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.8/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(PROJECT_DIR, 'var', 'static')
STATICFILES_ROOT = os.path.join(PROJECT_DIR, 'static')
STATICFILES_DIRS = (STATICFILES_ROOT,)


# Media files

MEDIA_ROOT = os.path.join(PROJECT_DIR, 'var', 'media')
MEDIA_URL = '/media/'


# Auth

LOGIN_URL = '/login/'
LOGOUT_URL = '/logout/'
LOGIN_REDIRECT_URL = '/'


# Mail

SERVER_EMAIL = 'server@project.com'
EMAIL_SUBJECT_PREFIX = '[project.com] '  # for mailing admins and managers

DEFAULT_FROM_EMAIL = 'noreply@project.com'


# Local

from .settings_local import *
