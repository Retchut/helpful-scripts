#!/bin/bash

# This script will synchronize all en, pt and pt-BR srt subtitle files present in the same directory as each of the .mkv files passed as parameters.
# In order to synchronize the subtitles, ffsubsync is used. Make sure you have it installed and/or are on an environment where you can use it. See more at https://github.com/smacke/ffsubsync
# Usage:
#    ./sync-subs.sh <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./sync-subs.sh ./e01.mkv ./e02.mkv
#           or
#    ./sync-subs.sh ./*.mkv
#
# Result:
#   ./e01.en.srt ./e01.pt.srt ./e01.pt-BR.srt (if they exist) are synchronized to ./e01.mkv
#   ./e02.en.srt ./e02.pt.srt ./e02.pt-BR.srt (if they exist) are synchronized to ./e02.mkv

if command -v ffsubsync > /dev/null 2>&1; then
    echo "ffsubsync installed - proceeding"
else
    echo "ffsubsync is not installed on this environment. Please install it or enter an environment where it exists before re-running this script"
    exit 1
fi

LANG_SUFFIXES=("en" "pt" "pt-BR")

for FILEPATH in "${@:1}";
do
    if [ ! -e "$FILEPATH" ]; then
        echo "$FILEPATH does not exist.";
        continue;
    fi
    
    DIRNAME="$(dirname -- "$FILEPATH")"
    BASENAME="$(basename -- "$FILEPATH")"
    FILENAME="${BASENAME%.*}"
    EXT="${BASENAME##*.}"
    
    if [ ! $EXT == "mkv" ]; then
        echo "$FILEPATH is not a mkv file - ignoring...";
        continue;
    fi
    
    for LANG in "${LANG_SUFFIXES[@]}"
    do
        SUB_FILE="$DIRNAME/$FILENAME.$LANG.srt"
        
        if [ -e "$SUB_FILE" ]; then
            echo "Synchronizing ..../$FILENAME.$LANG.srt";
            ffsubsync "$FILEPATH" -i "$SUB_FILE" -o "$SUB_FILE"
        fi
    done
done