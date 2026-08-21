#!/bin/bash

# ------------------------------------------------------------
# Linux Toolkit
# Script: system-info.sh
# Version: 1.0.0
# Author: Amber Moore
# Description: Prints system information
# ------------------------------------------------------------
VERSION="1.0.0"

echo "Linux Toolkit System Information v$VERSION"

HOST_NAME=$(hostname)
OS=$(uname)
KERNEL=$(uname -r)
ARCH=$(uname -m)
UPTIME=$(uptime)
CPU=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
MEMORY=$(free -h | awk 'NR==2 {print $2}')
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')
IP_ADDRESS=$(hostname -I | awk '{print $1}')

echo "========================================="
echo "Hostname:         $HOST_NAME"
echo "Operating System: $OS"
echo "Kernel:           $KERNEL"
echo "Architecture:     $ARCH"
echo "Uptime:           $UPTIME"
echo "CPU Model:        $CPU"
echo "Memory:           $MEMORY"
echo "Disk Usage:       ${DISK_USAGE}%"
echo "IP Address:       $IP_ADDRESS"
echo "========================================="
