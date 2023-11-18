#!/bin/bash

# This script will rename all files passed as parameters, adding a strig (passed as parameter) at the end of their from their filenames, and preserving the rest of the string
# Usage:
#    ./add-ending.sh <string to add> <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./add-ending.sh ".jp" ./subtitles/*.srt
#           or
#    ./add-ending.sh ".jp" ./subtitles/episode1.srt ./subtitles/episode2.srt
#
# file "./subtitles/episode1.srt" is moved to "./subtitles/episode1.jp.srt"
# file "./subtitles/episode2.srt" is moved to "./subtitles/episode2.jp.srt"


file_add_ending(){
    to_add="$1"
    filepath="$2"
    finalname=""
    basename="$(basename -- "$filepath")"
    dirname="$(dirname -- "$filepath")"
    
    if [ -d "$filepath" ]; then
        newfoldername="$basename$to_add"
        finalname="$dirname/$newfoldername"
    else
        filename="${basename%.*}"
        extension="${basename##*.}"
        
        newfilename="$filename$to_add"
        finalname="$dirname/$newfilename.$extension"
    fi
    
    mv "$dirname/$basename" "$finalname"
}

to_add=$1

for filepath in "${@:2}"
do
    file_add_ending "$to_add" "$filepath"
done