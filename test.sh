#!/bin/bash


### configs

script_dir=$(cd $(dirname $0); pwd)

showns_dir=${script_dir}/docs/
spheres_dir=${script_dir}/spheres/

deployed_uri="https://i-makinori.github.io/"
git_uri="https://github.com/i-makinori/i-makinori.github.io/"

function message(){
    echo -e $@
}

### utilities

BLUE=`tput setaf 4`
NOCOLOR=`tput sgr0`


### compile sphere ... apply template and make file

list_spheres=($(find ${spheres_dir} -print))
template_file=${script_dir}/scripts/template.html


for posts_path in ${list_spheres[@]}; do
    docs_file_path=${showns_dir}${posts_path##${spheres_dir}}

    message -n ${BLUE} ${posts_path#${script_dir}}
    message ${NOCOLOR} " -> " ${docs_file_path#${script_dir}}
    
    mkdir -p ${docs_file_path%/*}
    if [ -d ${posts_path} ]; then
        :
    elif [ -f ${posts_path} ] && [ ${posts_path##*.} == md ]; then
        html_path=${docs_file_path%.*}.html
        export title="hogehgoe"
        export body=$(pandoc --mathjax --from markdown --to html ${posts_path})
        cat ${template_file} | envsubst > ${html_path}
    else
        cp ${posts_path} ${docs_file_path}
    fi
done


### list of spheres




#### webfsd

webfsd -p 3000 -r ${showns_dir}