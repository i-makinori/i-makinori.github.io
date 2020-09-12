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

#### to index directory


### documents ... apply template and make file

list_spheres=($(find ${posts_dir} -print))
#list_inospheres=($(find ${posts_dir} -maxdepth 1 -not -type d) )
template_file=${script_dir}/scripts/template.html


for posts_path in ${list_spheres[@]}; do

    docs_file_path=${showns_dir}${posts_path##${posts_dir}}
    message "\t" ${posts_path#${script_dir}}  " -> " ${docs_file_path}

    
    mkdir -p ${docs_file_path%/}
    if [ -d ${posts_path} ]; then
        :
    elif [ -f ${posts_path} ] && [ ${posts_path##*.} == md ]; then
        html_path=${docs_file_path%.*}.html
        echo ${html_path}
        export title="hogehgoe"
        export body=$(pandoc --mathjax --from markdown --to html ${posts_path})
        cat ${template_file} | envsubst > ${html_path}
    else
        mkdir -p ${docs_file_path%/}
        cp ${posts_path} ${docs_file_path}
    fi

    #message ""    
done

### 

#### webfsd

#webfsd -p 3001 -r ${showns_dir}

