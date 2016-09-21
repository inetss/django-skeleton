# Dokku

Проект установлен на платформу [Dokku](http://dokku.viewdocs.io/dokku/).

В дальнейшнем подразумевается, что у оператора установлен [официальный клиент для командной строки](http://dokku.viewdocs.io/dokku/community/clients/#bash-zsh-etc-dokku_clientsh) `dokku`.

## Начальная установка

В локальной копии оператора:

```bash
DOKKU_HOST=dokku.me dokku apps:create acme
dokku postgres:create acme
dokku postgres:connect acme < acme.backup.sql
dokku postgres:link acme acme
dokku config:set SECRET_KEY=$(pwgen -s 50 -n 1)
dokku storage:mount /var/lib/dokku/data/storage/acme/media:/app/var/media
dokku config:set \
	ALLOWED_HOSTS=acme.com \
	SENTRY_DSN=https://xxx:yyy@sentry.com/12345
git push dokku master
dokku domains:add acme.com www.acme.com
dokku redirect:set acme www.acme.com acme.com
dokku letsencrypt acme
```

Теперь приложение доступно по адресу <https://acme.com>.

## Обновление лайва

### ВНИМАНИЕ: Настроено автоматическое обновление!

Лайв обновляется автоматически из ветки `master` с помощью Gitlab CI: <https://git.acme.com/acme/acme/pipelines>

Настройка в файле `.gitlab-ci.yml` в корне проекта.

### Ручное обновление

Ручное обновление производить только при выключенном или неработающем Gitlab CI.

В локальной копии оператора:

```bash
git push dokku@dokku.me:acme HEAD:master --force
```

Лайв будет обновлён текущей локальной веткой.