#!/bin/bash

# This script will rename all files passed as parameters, replacing all instances of the delimiter passed as parameter with another token, and preserving the rest of the string
# Usage:
#    ./replace-token.sh <delimiter> <new token> <filepath1> <filepath2> <filepath3>
#
# Example:
#    replace-token.sh : ' ' ./files/*
#           or
#    replace-token.sh : ' ' ./files/0:30.txt ./files/1:24.txt
#
# file "./files/0:30.txt" is moved to "./files/0 30.txt"
# file "./files/1:24.txt" is moved to "./files/1 24.txt"

file_replace_token(){
    delim="$1"
    token="$2"
    filepath="$3"
    finalname=""
    basename="$(basename -- "$filepath")"
    dirname="$(dirname -- "$filepath")"
    
    if [ -d "$filepath" ]; then
        newfoldername="${basename//$delim/$token}"
        finalname="$dirname/$newfoldername"
    else
        filename="${basename%.*}"
        extension="${basename##*.}"
        
        newfilename="${filename//$delim/$token}"
        finalname="$dirname/$newfilename.$extension"
    fi
    
    mv "$dirname/$basename" "$finalname"
}

delim=$(printf '%q\n' "$1")
token="$2"

for filepath in "${@:3}"
do
    file_replace_token "$delim" "$token" "$filepath"
done