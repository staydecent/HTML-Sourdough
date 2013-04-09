#!/bin/bash 
set -e

# 
# Build
#  Read scripts/concat.py to figure this out
# 

[ -d ./public ] && rm -R ./public
mkdir ./public

cp -r app/static public/static


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

components=`python ./scripts/concat.py 'components' 'public/components.js' ${libsJoined} | tail -n 1`
if [ -z "$components" ]; then
  echo "Error concatenating components"
  exit 1
else
  echo $components
fi


# ----------
# App

app=`python ./scripts/concat.py 'app' 'public/app.js' | tail -n 1`
if [ -z "$app" ]; then
  echo "Error concatenating app"
  exit 1
else
  echo $app
fi