#!/bin/bash

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
GRAY="$(tput setaf 7)"
NORMAL="$(tput sgr0)"

commands1="git"
commands2="npm"

for i in 1 2
do
    c="commands$i"
    eval origin=\$$c
    hash echo $origin >/dev/null 2>&1 || {
    echo "${YELLOW}Error: $origin is not installed\n"
    exit 1
}
done

name=`git config user.name`
name=${name:-someone}
email=`git config user.email`
name=${name:-someone@mail.com}
userInfo="${name} <${email}>"

read -p "Project name? ${YELLOW}(vue)${NORMAL} " project
project=${project:-vue}
echo "${GREEN}$project${NORMAL}\n"

read -p "Project description? ${YELLOW}(A Vue.js project)${NORMAL} " description
description=${description:-A Vue.js project}
echo "${GREEN}$description${NORMAL}\n"

read -p "Author? ${YELLOW}($userInfo)${NORMAL} " author
author=${author:-$userInfo}
echo "${GREEN}$author${NORMAL}\n"

git clone https://github.com/benjaminchen/vue-install-tool.git $project
cd ./$project

echo "{
  \"name\": \"$project\",
  \"version\": \"0.0.1\",
  \"description\": \"$description\",
  \"main\": \"index.js\",
  \"scripts\": {
    \"test\": \"echo \\\"Error: no test specified\\\" && exit 1\",
    \"build\": \"webpack\",
    \"watch\": \"webpack --watch\",
    \"dev\": \"webpack && webpack-dev-server\",
    \"production\": \"NODE_ENV=production webpack\"
  },
  \"author\": \"$author\",
  \"license\": \"ISC\",
  \"devDependencies\": {
    \"clean-webpack-plugin\": \"^0.1.17\",
    \"copy-webpack-plugin\": \"^4.1.0\",
    \"css-loader\": \"^0.28.7\",
    \"extract-text-webpack-plugin\": \"^3.0.0\",
    \"html-loader\": \"^0.5.1\",
    \"html-webpack-plugin\": \"^2.30.1\",
    \"jquery\": \"^3.2.1\",
    \"lodash\": \"^4.17.4\",
    \"node-sass\": \"^4.5.3\",
    \"pug-html-loader\": \"^1.1.5\",
    \"sass-loader\": \"^6.0.6\",
    \"style-loader\": \"^0.18.2\",
    \"uglifyjs-webpack-plugin2\": \"^1.0.3\",
    \"vue\": \"^2.4.4\",
    \"vue-loader\": \"^13.0.5\",
    \"vue-material\": \"^0.7.5\",
    \"vue-router\": \"^3.0.1\",
    \"vue-template-compiler\": \"^2.4.4\",
    \"webpack\": \"^3.6.0\",
    \"webpack-dev-server\": \"^2.9.3\"
  }
}" > package.json

echo "# $project" > README.md

npm install

rm -rf ./.git

echo "
    Generated \"$project\".

    To get started:

        cd $project
        npm run dev

    Usage can be found at https://github.com/benjaminchen/vue-install-tool
"

rm ./install.sh
