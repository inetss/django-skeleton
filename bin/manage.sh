#!/usr/bin/env bash

cd `dirname $(cd ${0%/*} && echo $PWD/${0##*/})`
./venv.sh src/manage.py $*
