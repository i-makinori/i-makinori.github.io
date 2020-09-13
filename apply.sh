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
tmp_file=${script_dir}/scripts/temporary.txt

for posts_path in ${list_spheres[@]}; do
    docs_file_path=${showns_dir}${posts_path##${spheres_dir}}

    # message -n ${BLUE} ${posts_path#${script_dir}}
    # message ${NOCOLOR} " -> " ${docs_file_path#${script_dir}}
    
    mkdir -p ${docs_file_path%/*}
    if [ -d ${posts_path} ]; then
        :
    elif [ -f ${posts_path} ] && [ ${posts_path##*.} == md ]; then
        html_path=${docs_file_path%.*}.html
        touch ${tmp_file}
        mode="title"
        while read line; do
            # title
            if [ "${mode}" == "title" ]; then
                if   [ "${line::2}" == "# " ]; then title=${line:2};
                elif [ "${line}"    == ""   ]; then :
                else mode="body"; fi 
            fi
            # body
            if [ "${mode}" == "body" ]; then
                echo ${line} >> ${tmp_file}
            fi
        done < ${posts_path}

        export title=${title}
        export body=$(pandoc --mathjax --from markdown --to html ${tmp_file})

        # template
        cat ${template_file} | envsubst > ${html_path}
        rm ${tmp_file}
    else
        # echo ${posts_path} ${docs_file_path}
        cp ${posts_path} ${docs_file_path}
    fi

done



### list of spheres


directory=""
pathname=""

touch ${tmp_file}

function directory_aux(){ # $1: dir, $2: file
    dir_uri=${1#${script_dir}/docs}${2}

    if [ -d ${1}${2} ]; then
        echo "<li>${dir_uri}</li>" >> ${tmp_file}
        echo "<ul>" >> ${tmp_file}
        for file in $(ls -p ${1} | grep -v /); do
            directory_aux ${1} ${file}
        done
        for dir in $(ls -F ${1} | grep \/$) ; do
            directory_aux ${1}${dir}
        done
        echo "</ul>" >> ${tmp_file}
    elif [ -f ${1}${2} ]; then
        a_tag="<a href=\"${dir_uri}\">${2}</a>"
        echo "<li>${a_tag}</li>" >> ${tmp_file}
    fi
}

echo "<ul>" >> ${tmp_file}
directory_aux ${showns_dir}
echo "</ul>" >> ${tmp_file}

export title="spheres whole site"
export body=$(cat ${tmp_file})


sphere_map_path=${showns_dir}sphere-map.html


cat ${template_file} | envsubst > ${sphere_map_path}

rm ${tmp_file}

