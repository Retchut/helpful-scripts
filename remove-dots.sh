#! /bin/bash

# This script will rename all files IN THE CURRENT DIRECTORY OF THE SCRIPT, removing all dot characters present in their filenames
# Usage:
#    ./remove-dots.sh
#
# Examples:
#   ./remove-dots.sh
# file "./test.file.txt" is moved to "./testfile.txt"

for i in *.*; do
    [ -d "$i" ] || continue
    mv -- "$i" "${i//./}"
done

