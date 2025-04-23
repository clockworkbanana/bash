#!/bin/bash

# This script will copy all the contents of directory $1 to directory $2, ensuring that the order of file creation matches the alphabetical order
# 
# Please be aware that this script is not guaranteed to work properly and is not fool- or failure- proof so you use it on your own risk.
# However, it was written with good intentions and, to best of my knowledge, should not delete anything even if you use it wrong.    

# First make sure it's executable by running:
#     $ chmod +x sorted_copy.sh
# Usage:
#     $ ./sorted_copy.sh [source dir] [target dir]
# e.g.,:
#     $ ./sorted_copy.sh ~/Music /Volumes/MP3DRIVE 



# Assign variables and strip trailing '/' if it is present
src_root="${1%/}"
dst_root="${2%/}" 

# Find all the contents of src | sort | iterate 
find "$src_root" -type f | sort | while IFS= read -r src; do
    echo "Processing: $src"

    # Build full destination path
    rel_path="${src#$src_root}"      # relative path = (original file path) - (src_root)
    dest_path="$dst_root$rel_path"   # destination path = (destination root) + (relative path)
    echo "    Destination path: $dest_path"

    # Create directory if it doesn't exist
    echo "    > mkdir -p "$(dirname "$dest_path")""
    mkdir -p "$(dirname "$dest_path")"
  
    # Copy the file
    echo "    > cp "$src" "$dest_path""
    cp "$src" "$dest_path"

    echo "    Done."

done
echo "End of script."
