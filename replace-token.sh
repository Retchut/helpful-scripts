#!/bin/bash

# This script will rename the file passed as parameter, replacing all instances of the delimiter passed as parameter with another token
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

    fullfilename=$(basename -- "$filepath")
    dirname=$(dirname -- "$filepath")
    filename="${fullfilename%.*}"
    extension="${fullfilename##*.}"

    newfilename="${filename//$delim/$token}"

    mv "$dirname/$fullfilename" "$dirname/$newfilename.$extension"
}

delim=$1
token=$2

for filepath in "${@:3}"
do 
    file_replace_token "$delim" "$token" "$filepath"
done