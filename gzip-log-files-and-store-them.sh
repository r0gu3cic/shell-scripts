#!/bin/bash

# Set the directory path where your files are located
source_directory="</path/to/the/log/files>"
log_backup_directory="</path/to/the/directory/in/which/files/should/be/stored>"

# Change to the source directory
cd "$source_directory" || exit 1

# Create log_backup directory if it doesn't exist
mkdir -p "$log_backup_directory"

# Iterate through all files in the directory
for file in *; do
    if [ -f "$file" ] && [[ "$file" == *.log ]]; then
        # Gzip the .log file
        gzip "$file"
        
        # Move the gzipped file to log_backup directory
        mv "$file.gz" "$log_backup_directory/"
        
        # # Remove the original .log file
        # rm "$file"
        # # No need for this, gzip already removes it

        echo "Processed $file"
    fi
done
