#!/bin/bash

# ------------------------------------------------------------
# Linux Toolkit
# Script: backup.sh
# Version: 0.2.0
# Author: Amber Moore
# Description: Creates a backup using rsync and reports the results.
# ------------------------------------------------------------

VERSION="0.2.0"

echo "Linux Toolkit Backup Utility v$VERSION"
echo "------------------------------------"


SOURCE="$1"
DESTINATION="$2"

if [ -z "$SOURCE" ] || [ -z "$DESTINATION" ]; then
	echo "Usage: $0 <source> <destination>"
	exit 1
fi

if [ ! -d "$DESTINATION" ]; then
	echo "Creating destination directory..."
	mkdir -p "$DESTINATION"
fi

if [ ! -d "$SOURCE" ]; then
	echo "ERROR: Source directory does not exist."
	exit 1
fi

echo
echo "Backup Configuration"
echo "--------------------"
echo "Source:      $SOURCE"
echo "Destination: $DESTINATION"
echo

read -p "Proceed with backup? (y/N): " ANSWER

if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
	echo "Backup cancelled."
	exit 0
fi

echo 
echo "Starting backup..."

rsync -av "$SOURCE/" "$DESTINATION/"
BACKUP_STATUS=$?

echo 

if [ "$BACKUP_STATUS" -eq 0 ]; then
	
	FILE_COUNT=$(find "$DESTINATION" -type f | wc -l | xargs)
	DIRECTORY_COUNT=$(find "$DESTINATION" -type d | wc -l | xargs)
	FINISHED_AT=$(date)
	
	echo
	echo "========== Backup Summary =========="
	echo "Status: SUCCESS"
	echo "Files copied: $FILE_COUNT"
	echo "Directories copied: $DIRECTORY_COUNT"
	echo "Finished at: $FINISHED_AT"
	echo "===================================="
else
    echo "===================================="
	echo "Status: FAILED"
	echo "Please review the rsync output above."
	echo "===================================="
    exit 1
fi

echo
