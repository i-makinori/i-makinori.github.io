#!/bin/bash

path=spheres/inosphere/thought.md
#path=spheres/inosphere/markdown-sample.md



while read line
do
    if [ "${line::2}" == "# " ]; then
        ans=${line:2}
    elif [ "${line}" == "" ]; then
        :
    else
        break
    fi
done < ${path}


return ${ans}