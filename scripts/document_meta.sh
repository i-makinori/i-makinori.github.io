#!/bin/bash

# args

while getopts p:tb: OPT
do
  case $OPT in
    "p" ) PATHNAME=${OPTARG} ;;
    # title
    "t" ) TITLE_P="TRUE" ;; 
    # body
    "b" ) BODY_P="TRUE" ; TMP_FILE="$OPTARG" ; echo > ${TMP_FILE} ;;
      * ) echo "Usage: ./pathname pathname [-p parsed_pathname] [-t] [-b tmp_file_pathname]" 1>&2
          exit 1 ;;
  esac
done

if [ -z "$PATHNAME" ]; then
    echo "pathname are not set."
    exit 1
fi

#



# parse

mode="title"
while read line; do
    # title
    if [ "${mode}" == "title" ]; then
        if   [ "${line::2}" == "# " ]; then title=${line:2};
        elif [ "${line}"    == ""   ]; then :
        else mode="body"; fi 
    fi
    # body
    if [ "${mode}" == "body" ] && [ "$BODY_P" == "TRUE" ]; then
        echo ${line} >> ${TMP_FILE}
    fi
done < ${PATHNAME}


# retuen

if [ "$TITLE_P" = "TRUE" ]; then
    echo ${title}
fi

if [ "$BODY_P" = "TRUE" ]; then
    :
fi


exit 0

