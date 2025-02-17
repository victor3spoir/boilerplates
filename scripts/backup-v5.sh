#!/bin/bash

# Check if the required arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <volume_map_file> <backup_directory>"
    exit 1
fi

# Input arguments
VOLUME_FILE="$1"
BACKUP_DIR="$2"

# Check if the volume mapping file exists
if [[ ! -f "$VOLUME_FILE" ]]; then
    echo "Error: Volume mapping file '$VOLUME_FILE' not found."
    exit 1
fi

# Create the backup directory with today's date
TODAY=$(date +%F)
BACKUP_DIR="$BACKUP_DIR/$TODAY"
mkdir -p "$BACKUP_DIR"

# Declare an associative array for the mapping
declare -A volume_map

# Read the file and populate the associative array
while IFS=: read -r volume path; do
    volume_map["$volume"]="$path"
done < "$VOLUME_FILE"

# Loop through the volume_map and back them up
for VOLUME in "${!volume_map[@]}"; do
    MOUNT_PATH=${volume_map[$VOLUME]}
    BACKUP_FILE="$BACKUP_DIR/$VOLUME-backup.tar.gz"
    echo "Backing up volume: $VOLUME (mounted at $MOUNT_PATH) to $BACKUP_FILE"
    
    # Backup each volume into a tar.gz file
    docker run --rm \
        -v "$VOLUME":"$MOUNT_PATH" \
        -v "$BACKUP_DIR":/backup \
        alpine tar -czf /backup/"$VOLUME-backup.tar.gz" -C "$MOUNT_PATH" .
done

echo "All backups saved to $BACKUP_DIR"
