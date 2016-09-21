# Установка локальной копии разработчика

## Установить необходимый софт

### OS X

При установленном [Homebrew](http://brew.sh/):

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

## Создать базу (PostgreSQL)

```bash
createdb acme
```

## Склонировать проект

```bash
git clone git@github.com:acme/acme.git
cd acme
```

## Настроить локальный конфиг

```bash
cp src/acme/local_settings.sample.py src/acme/local_settings.py
```

## Обновить зависимости

```bash
./manage install
bower install
```

## Обновить структуру БД

```
./manage migrate
```

## Создать локального админа

```
./manage createsuperuser
```

## Запустить локальный сервер

```
./manage runserver
```

Проект запущен по адресу <http://localhost:8000>.
