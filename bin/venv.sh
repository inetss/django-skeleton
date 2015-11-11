#!/usr/bin/env bash

VENV_BIN=pyvenv-3.5
VENV_PATH=var/venv

if [ "$*" == "" ]; then
	cat >&2 <<END
Usage: $0 [install|shell|<any command>]

	install: install packages from requirements.txt
	shell: run interactive shell ($SHELL)

Example: $0 pip freeze
END
	exit 1
fi

cd `dirname $(cd ${0%/*} && echo $PWD/${0##*/})`
cd ..

die() { echo $@ 1>&2 ; exit 1; }

[ -d "$VENV_PATH" ] || mkdir -p "$VENV_PATH" || die "Failed to create venv folder at $VENV_PATH"
[ -f "$VENV_PATH/bin/python" ] || $VENV_BIN "$VENV_PATH" || die "Failed to initialize venv at $VENV_PATH"
. "$VENV_PATH/bin/activate" || die "Failed to activate venv at $VENV_PATH"

case $1 in
install)
	pip install --upgrade pip
	pip install -r requirements.txt
	;;
shell)
	$SHELL
	;;
*)
	"$@"
	;;
esac
