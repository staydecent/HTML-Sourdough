#!/bin/bash 
set -e

[ -d ./public ] && rm -R ./public
mkdir -p ./public/js

# 
# Copy static files
# 

cp -r app/static public/static
cp app/index.html public/index.html

cd ./app
ls | egrep 'txt|ico' | while read -r file
do
    cp "${file}" "../public/${file}"
done
cd ../

# 
# Run build_js
# 

tools/build_js/node_modules/adhesive/adhesive.js tools/build_js/app.build.json --debug