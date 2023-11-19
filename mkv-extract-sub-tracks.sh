#!/bin/bash

# This script will extract a track provided from all mkv files passed as parameters (and only mkv files), saving it as either an .srt or an .ass file (same base filename as the mkv file provided)
# Providing the program with the correct track is necessary (if you provide an audio track to the program, it will be treated as if it were a subtitle track - ie: extracted and saved to a .srt/.ass file)
# Usage:
#    ./mkv-extract-sub-tracks.sh <track number> <track type: srt/ass> <lang extension: en/pt/pt-BR> <filepath1> <filepath2> <filepath3>
#
# Examples:
#    ./mkv-extract-sub-tracks.sh 3 srt en e01.mkv e02.mkv
#           or
#    ./mkv-extract-sub-tracks.sh 3 ass pt ./*.mkv

TRACK=$1
TYPE=$2
LANGEXT=$3

printUsage(){
    echo "usage:"
    echo -e "\t ./mkv-extract-sub-tracks.sh <track number> <track type: srt/ass> <file1> <file2> <...>"
}

# verify that the track type provided is valid
if [ "$TYPE" != "srt" ] && [ "$TYPE" != "ass" ]
then
    echo "Invalid track type - must be srt or ass"
    printUsage
    exit;
fi

# verify that the track lang ext provided is valid
if [ "$LANGEXT" != "en" ] && [ "$LANGEXT" != "pt" ] && [ "$LANGEXT" != "pt-BR" ]
then
    echo "Invalid track language extension - must be en, pt or pt-BR"
    printUsage
    exit;
fi

# if track is not empty and we can perform an integer comparison on it (it is an integer)
if [ -n "$TRACK" ] && [ "$TRACK" -eq "$TRACK" ] 2>/dev/null;
then
    for FILEPATH in "${@:4}";
    do
        DIRNAME="$(dirname -- "$FILEPATH")"
        BASENAME="$(basename -- "$FILEPATH")"
        FILENAME="${BASENAME%.*}"
        EXT="${BASENAME##*.}"
        if [ -d $filepath ] && [ $EXT == "mkv" ]; then
            echo "Extracting track $TRACK from $DIRNAME/$BASENAME -> $DIRNAME/$FILENAME.$LANGEXT.$TYPE";
            mkvextract tracks "$DIRNAME/$BASENAME" $TRACK:"$DIRNAME/$FILENAME.$LANGEXT.$TYPE"
        else
            echo "File $DIRNAME/$BASENAME is not a mkv file - skipped";
        fi
    done
else
    echo "invalid track value - track must be an integer"
    printUsage;
fi