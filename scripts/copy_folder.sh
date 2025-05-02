#!/usr/bin/env bash

# copy_folder.sh — copy all contents of one folder to another
# Usage: ./copy_folder.sh /path/to/src /path/to/dst

# Exit immediately on errors
set -e

# Check for exactly two arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <src_directory> <dst_directory>"
  exit 1
fi

src="$1"
dst="$2"

# Verify source exists and is a directory
if [ ! -d "$src" ]; then
  echo "Error: Source directory '$src' does not exist or is not a directory."
  exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$dst"

# Copy everything, including hidden files (those beginning with .)
# The trailing slash and dot ensure we copy the contents of src, not the directory itself.
cp -a "$src"/. "$dst"/

echo "All contents of '$src' have been copied to '$dst'."
