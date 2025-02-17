#!/bin/bash

# Input file containing the volume-to-path mappings
VOLUME_FILE="volume_map.txt"

# Check if the file exists
if [[ ! -f "$VOLUME_FILE" ]]; then
    echo "Error: Volume mapping file '$VOLUME_FILE' not found."
    exit 1
fi

# Declare an associative array for the mapping
declare -A volume_map

# Read the file and populate the associative array
while IFS=: read -r volume path; do
    volume_map["$volume"]="$path"
done < "$VOLUME_FILE"

# Get today's date in yyyy-mm-dd format
TODAY=$(date +%F)

# Directory to save backups
BACKUP_DIR="/path/to/backup/$TODAY"
mkdir -p "$BACKUP_DIR"

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
