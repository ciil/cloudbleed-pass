#!/bin/bash

CLOUDFLARE_FILE=./sorted_unique_cf.txt

find ${PASSWORD_STORE_DIR} -not -path '*/\.*' -type f -follow -print | while read f; do
    base_filename=${f##*/}
    base_filename_without_gpg=${base_filename%.*}
    base_filename_as_array=(${base_filename_without_gpg//./ })
    base_filename_array_length=${#base_filename_as_array[@]}
    j=${base_filename_array_length}-1
    domains=${base_filename_as_array[${base_filename_array_length}-1]}
    for (( i=${j}-1; i>=0; i-- ))
    do
        domains=${base_filename_as_array[i]}'.'$domains
        grep -Fx "${domains}" ${CLOUDFLARE_FILE}
    done
done
