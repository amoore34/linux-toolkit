#!/bin/bash

VERSION="0.1.0"

echo "Linux Toolkit Backup Utility v$VERSION"
echo "------------------------------------"

SOURCE="$HOME/linux-toolkit-test"
DESTINATION="/tmp/linux-toolkit-backup"

echo "Source: $SOURCE"
echo "Destination: $DESTINATION"

if [ ! -d "$DESTINATION" ]; then
	echo "Creating destination directory..."
	mkdir -p "$DESTINATION"
fi

if [ ! -d "$SOURCE" ]; then
	echo "ERROR: Source directory does not exist."
	exit 1
fi

read -p "Proceed with backup? (y/N): " ANSWER

if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
	echo "Backup cancelled."
	exit 0
fi

echo ""
echo "Starting backup..."

rsync -av "$SOURCE/" "$DESTINATION/"

echo ""
echo "Backup completed successfully."

FILE_COUNT=$(find "$DESTINATION" -type f | wc -l)
DIRECTORY_COUNT=$(find "$DESTINATION" -type d | wc -l)

echo "Files copied: $FILE_COUNT"
echo "Directories copied: $DIRECTORY_COUNT"

