#!/bin/bash


script_dir=$(cd $(dirname $0); pwd)
# read utilities and configs
source ${script_dir}/scripts/utils.sh 


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

        title=$(${script_dir}/scripts/document_meta.sh -p ${posts_path} -t -b ${tmp_file})
            # title: echoed return, body: in_tmp_file

        export title=${title}
        export body=$(pandoc --mathjax --from markdown --to html ${tmp_file})
        
        datetime=$(git log --pretty=format:%cd -n 1 --date=iso ${posts_path})
        export datetime=${datetime}

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
    # dir_uri=${showns_dir}${2}
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

