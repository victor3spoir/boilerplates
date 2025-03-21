#!/bin/bash

# Define an associative array for volume-to-mount-path mapping
declare -A volume_map=(
    [volume1]="/path/in/container1"
    [volume2]="/path/in/container2"
    [volume3]="/path/in/container3"
)

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
