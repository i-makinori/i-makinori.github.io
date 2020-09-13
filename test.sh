#!/bin/bash

filename=docs/

datetime=$(git log --pretty=format:%cd -n 1 --date=iso ${filename})
echo $datetime
