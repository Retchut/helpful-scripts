#!/bin/bash

# This script will rename all files passed as parameters, removing the last N characters (number passed as parameter) from their filenames, and preserving the rest of the string
# Usage:
#    ./remove-ending.sh <string to remove> <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./remove-ending.sh the_cake_is_a_ ./files/*
#           or
#    ./remove-ending.sh the_cake_is_a_ ./files/the_cake_is_a_lie.txt ./files/the_cake_is_a_cat.txt
#
# file "./files/the_cake_is_a_lie.txt" is moved to "./files/lie.txt"
# file "./files/the_cake_is_a_cat.txt" is moved to "./files/cat.txt"


file_remove_ending(){
    remove_num="$1"
    filepath="$2"

    fullfilename="$(basename -- "$filepath")"
    dirname="$(dirname -- "$filepath")"
    filename="${fullfilename%.*}"
    extension="${fullfilename##*.}"

    newfilename=${filename::-$remove_num}
    mv "$dirname/$fullfilename" "$dirname/$newfilename.$extension"
}

remove_num=$1

for filepath in "${@:2}"
do
    file_remove_ending "$remove_num" "$filepath"
done