#!/bin/bash


### configs

script_dir=$(cd $(dirname $0); pwd)


showns_dir=${script_dir}/docs/
posts_dir=${script_dir}/spheres/
draft_server="localhost:3000/"
shown_server="https://github.com/i-makinori/corruption-log/."

function message(){
    echo -e $@
}

### utilities

BLUE=`tput setaf 4`
NOCOLOR=`tput sgr0`

#### to index directory


### documents ... apply template and make file

list_spheres=($(find ${posts_dir} -print))
#list_inospheres=($(find ${posts_dir} -maxdepth 1 -not -type d) )
template_file=${script_dir}/scripts/template.html


for posts_path in ${list_spheres[@]}; do

    docs_file_path=${showns_dir}${posts_path##${posts_dir}}
    message -n ${BLUE} ${posts_path#${script_dir}}
    message ${NOCOLOR} " -> " ${docs_file_path#${script_dir}}
    #    message ${docs_file_path%/}
    
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

    #message ""    
done

### 


#### webfsd

webfsd -p 3000 -r ${showns_dir}