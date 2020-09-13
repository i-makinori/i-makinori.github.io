#!/bin/bash

#### webfsd


script_dir=$(cd $(dirname $0); pwd)
showns_dir=${script_dir}/docs/


webfsd -p 3000 -r ${showns_dir} -f /index.html