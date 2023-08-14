#!/bin/bash

# This script will rename the file passed as parameter, replacing all of their extensions to the one passed as parameter
# Usage:
#    ./change-extension.sh <new extension> <filepath1> <filepath2> <filepath3>
#
# Example:
#    change-extension.sh : png ./jpegimg/*
#           or
#    change-extension.sh : ' ' ./jpegimg/01.jpeg ./jpegimg/02.jpeg
#
# file "./jpegimg/01.jpeg" is moved to "./jpegimg/01.png"
# file "./jpegimg/02.jpeg" is moved to "./jpegimg/02.png"

file_change_extension(){
    toremove="$1"
    filepath="$2"
    finalname=""
    basename="$(basename -- "$filepath")"
    dirname="$(dirname -- "$filepath")"

    if [ -f $filepath ]; then
        filename="${basename%.*}"

        finalname="$dirname/$filename.$extension"

        mv "$dirname/$basename" "$finalname"
    fi
}

extension=$(printf '%q\n' "$1")

for filepath in "${@:2}"
do 
    file_change_extension "$extension" "$filepath"
done