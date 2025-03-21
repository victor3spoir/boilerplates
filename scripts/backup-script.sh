#!/bin/bash

# Get today's date in yyyy-mm-dd format
TODAY=$(date +%F)

# Directory to save backups
BACKUP_DIR="/path/to/backup/$TODAY"
mkdir -p "$BACKUP_DIR"

# Loop through Docker volumes and back them up
for VOLUME in $(docker volume ls --format "{{.Name}}"); do
    # Backup each volume into a tar.gz file
    BACKUP_FILE="$BACKUP_DIR/$VOLUME-backup.tar.gz"
    echo "Backing up volume: $VOLUME to $BACKUP_FILE"
    docker run --rm \
        -v "$VOLUME":/volume \
        -v "$BACKUP_DIR":/backup \
        alpine tar -czf /backup/"$VOLUME-backup.tar.gz" -C /volume .
done

echo "All backups saved to $BACKUP_DIR"
