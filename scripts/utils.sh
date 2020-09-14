#!/bin/bash


### configs

showns_dir=${script_dir}/docs/
spheres_dir=${script_dir}/spheres/

deployed_uri="https://i-makinori.github.io/"
git_uri="https://github.com/i-makinori/i-makinori.github.io/"


### utilities


## color

function message(){
    echo -e $@
}

## color

BLUE=`tput setaf 4`
NOCOLOR=`tput sgr0`


### exam
