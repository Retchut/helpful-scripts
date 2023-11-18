#!/bin/bash

# This script will rename all files passed as parameters, adding a strig (passed as parameter) at the start of their from their filenames, and preserving the rest of the string
# Usage:
#    ./add-leading.sh <string to add> <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./add-leading.sh "episode" ./subtitles/*.srt
#           or
#    ./add-leading.sh "episode" ./subtitles/1.srt ./subtitles/2.srt
#
# file "./subtitles/1.srt" is moved to "./subtitles/episode1.srt"
# file "./subtitles/2.srt" is moved to "./subtitles/episode2.srt"

file_add_leading(){
    to_add="$1"
    filepath="$2"
    finalname=""
    basename="$(basename -- "$filepath")"
    dirname="$(dirname -- "$filepath")"
    
    if [ -d "$filepath" ]; then
        newfoldername="$to_add$basename"
        finalname="$dirname/$newfoldername"
    else
        filename="${basename%.*}"
        extension="${basename##*.}"
        
        newfilename="$to_add$filename"
        finalname="$dirname/$newfilename.$extension"
    fi
    
    mv "$dirname/$basename" "$finalname"
}

to_add=$1

for filepath in "${@:2}"
do
    file_add_leading "$to_add" "$filepath"
done