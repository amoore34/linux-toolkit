#!/bin/bash

# Ensure the script is running on Linux
if [[ "$(uname)" != "Linux" ]]; then
    echo "This deployment script must be run on a Linux server."
    exit 1
fi

VERSION="1.0.0"

echo "Linux Portfolio Deployment Utility v$VERSION"
echo "--------------------------------------------"

SOURCE=$(pwd)
DESTINATION="/var/www/html"

if [[ ! -w "$DESTINATION" && $EUID -ne 0 ]]; then
    echo "ERROR: You don't have permission to write to $DESTINATION."
    echo "Try running:"
    echo "  sudo $0"
    exit 1
fi

echo
echo "Source:      $SOURCE"
echo "Destination: $DESTINATION"

echo
read -p "Deploy website? (y/N): " ANSWER

if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
    echo "Deployment cancelled."
    exit 0
fi
echo
echo "Deploying website..."
echo

rsync -av \
    --exclude=".git" \
    --exclude=".gitignore" \
    --exclude="README.md" \
    --exclude="scripts" \
    --exclude=".DS_Store" \
    "$SOURCE/" "$DESTINATION/"

DEPLOY_STATUS=$?

echo

if [ "$DEPLOY_STATUS" -eq 0 ]; then
    echo "========== Deployment Summary =========="
    echo "Status: SUCCESS"
    echo "Website deployed successfully."
    echo "Finished at: $(date)"
    echo "========================================"
else
    echo "ERROR: Deployment failed."
    exit 1
fi
