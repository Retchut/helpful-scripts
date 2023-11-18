#!/bin/bash

# This script will rename all folders passed as parameters, removing the last N characters (number passed as parameter) from their filenames, and preserving the rest of the string
# Usage:
#    ./remove-ending.sh <string to remove> <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./remove-ending.sh 4 ./files/*
#           or
#    ./remove-ending.sh 4 ./files/the_cake_is_a_lie.txt ./files/the_cake_is_a_cat.txt
#
# file "./files/the_cake_is_a_lie.txt" is moved to "./files/the_cake_is_a.txt"
# file "./files/the_cake_is_a_cat.txt" is moved to "./files/the_cake_is_a.txt"

file_remove_ending(){
    remove_num="$1"
    filepath="$2"
    finalname=""
    basename="$(basename -- "$filepath")"
    dirname="$(dirname -- "$filepath")"
    
    
    if [ -d "$filepath" ]; then
        newfoldername=${basename::-$remove_num}
        finalname="$dirname/$newfoldername"
    else
        filename="${basename%.*}"
        extension="${basename##*.}"
        
        newfilename=${filename::-$remove_num}
        finalname="$dirname/$newfilename.$extension"
    fi
    
    mv "$dirname/$basename" "$finalname"
}

remove_num=$1

for filepath in "${@:2}"
do
    file_remove_ending "$remove_num" "$filepath"
done