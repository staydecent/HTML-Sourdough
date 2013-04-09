#!/bin/bash 
set -e

# 
# Build
#  Read scripts/concat.py to figure this out
# 

[ -d ./public ] && rm -R ./public
mkdir -p ./public/js

cp -r app/static public/static
cp app/index.html public/index.html

cd ./app
ls | egrep 'txt|ico' | while read -r file
do
    cp "${file}" "../public/${file}"
done
cd ../


# ----------
# Components

declare -a libsBefore
libsBefore=(
  'jquery.min.js' 
  'underscore-min.js' 
  'backbone-min.js'
)

libsJoined+=$(printf ",%s" "${libsBefore[@]}")
libsJoined=${libsJoined:1}

components=`python ./scripts/concat.py 'components' 'public/js/components.js' ${libsJoined} | tail -n 1`
if [ -z "$components" ]; then
  echo "Error concatenating components"
  exit 1
else
  echo $components
fi


# ----------
# App

app=`python ./scripts/concat.py 'app' 'public/js/app.js' | tail -n 1`
if [ -z "$app" ]; then
  echo "Error concatenating app"
  exit 1
else
  echo $app
fi