#!/bin/bash

# This script counts the number of files in the directory passed as the first parameter
#   the "tag" parameter is any label to make the input more readable

dir=$1
tag=$2

echo "$tag: $(find -L $dir -type f | wc -l)"
