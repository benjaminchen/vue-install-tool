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

echo "# $project" > README.md

npm install

updateJson="./node_modules/.bin/json -I -f package.json -e 'this.name=\"$project\",this.description=\"$description\",this.author=\"$author\"'"

eval $updateJson

npm remove --save-dev json

rm -rf ./.git

echo "
    Generated \"$project\".

    To get started:

        cd $project
        npm run dev

    Usage can be found at https://github.com/benjaminchen/vue-install-tool
"

rm ./install.sh
