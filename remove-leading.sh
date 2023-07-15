#!/bin/bash

# This script will rename all files passed as parameters, removing the leading instance of the string passed as parameter from their filenames, and preserving the rest of the string
# Usage:
#    ./remove-leading.sh <string to remove> <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./remove-leading.sh the_cake_is_a_ ./files/*
#           or
#    ./remove-leading.sh the_cake_is_a_ ./files/the_cake_is_a_lie.txt ./files/the_cake_is_a_cat.txt
#
# file "./files/the_cake_is_a_lie.txt" is moved to "./files/lie.txt"
# file "./files/the_cake_is_a_cat.txt" is moved to "./files/cat.txt"


file_remove_leading(){
    toremove=$1
    filepath=$2

    fullfilename=$(basename -- "$filepath")
    dirname=$(dirname -- "$filepath")
    newfilename=$(echo $fullfilename | sed "s/$toremove//")

    mv "$dirname/$fullfilename" "$dirname/$newfilename"
}

toremove=$1

for filepath in "${@:2}"
do 
    file_remove_leading $toremove $filepath
done