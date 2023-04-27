#!/bin/bash
set -x
log_dir="/home/kuwajerw/terminal_logs"
max_size=$((1024 * 1024 * 1024)) # 1 GB in bytes

# Get the total size of the log folder in bytes
folder_size=$(du -sb "$log_dir" | cut -f1)

# Delete the oldest logs until the folder size is below max_size
while [ "$folder_size" -gt "$max_size" ]; do
    
    # get oldest file
    oldest_file=$(find "$log_dir" -type f -name "*" -printf '%T+ %p\n' | sort | head -n 1 | cut -d' ' -f2-)

    # delete it 
    rm "$oldest_file"

    # get next oldest file, will get deleted if folder size is still too big
    folder_size=$(du -sb "$log_dir" | cut -f1)
done
