#!/bin/bash

list=$(ls -R ./docs/)


directory=""
pathname=""

for row in ${list}; do
    if [ ${row} == "" ]; then
        :
    elif [ -d ${row%:} ]; then
        directory=${row%":"}
        directory=${directory%"/"}
        echo ${directory}
    else
        for name in ${row}; do
            pathname=${directory}/${row}
            if [ -f ${pathname} ]; then
                echo "  " ${pathname}
            fi
        done
    fi

done