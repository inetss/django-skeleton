#!/usr/bin/env bash

project=$1
app=$2
sed=$(which gsed || which sed)

if [ -z "$project" -o -z "$app" ]; then
	cat << EOF
Usage: $0 myproject myapp

myproject - desired project name
myapp - desired app name (for smaller projects, app can be the same as the project name)
EOF
	exit 1
fi

cd $(dirname $(cd ${0%/*} && echo $PWD/${0##*/}))  # cd to own directory
mv src/project/app src/project/$app
mv src/project src/$project
find src \( -name '*.py' -or -name '*.sample.py' \) -exec $sed -i"" "s/project\\.app/project.$app/" {} \;
find src \( -name '*.py' -or -name '*.sample.py' \) -exec $sed -i"" "s/project\\./$project./" {} \;
find src \( -name '*.py' -or -name '*.sample.py' \) -exec $sed -i"" "s/'project'/'$project'/" {} \;
find src \( -name '*.py' -or -name '*.sample.py' \) -exec $sed -i"" "s|app/|$app/|" {} \;
find templates -name '*.html' -exec $sed -i"" s/admin:app/admin:$app/ {} \;
mv templates/app templates/$app
rm $0
