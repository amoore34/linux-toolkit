#!/bin/bash

# ------------------------------------------------------------
# Linux Toolkit
# Script: system-info.sh
# Version: 1.0.0
# Author: Amber Moore
# Description: Prints system information
# ------------------------------------------------------------
VERSION="1.0.0"
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Linux Toolkit System Information"
    echo
    echo "Usage:"
    echo "    system-info.sh"
    echo
    echo "Description:"
    echo "    Displays system information including:"
    echo "      • Hostname"
    echo "      • Operating System"
    echo "      • Kernel Version"
    echo "      • Architecture"
    echo "      • CPU Model"
    echo "      • Memory Usage"
    echo "      • Disk Usage"
    echo "      • IP Address"
    echo "      • Uptime"
    exit 0
fi

echo "Linux Toolkit System Information v$VERSION"

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
OS=$(grep "^PRETTY_NAME=" /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
ARCH=$(uname -m)
CURRENT_SHELL=$(basename "$SHELL")
UPTIME=$(uptime)
CPU=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
CPU_CORES=$(nproc)
MEMORY_USED=$(free -m | awk '/Mem:/ {print $3}')
MEMORY_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEMORY=$(free -h | awk 'NR==2 {print $2}')
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')
IP_ADDRESS=$(hostname -I | awk '{print $1}')
GENERATED=$(date)


echo "========================================="
echo "Hostname:         ${HOSTNAME}"
echo "Operating System: ${OS}"
echo "Current User:     ${CURRENT_USER}"
echo "Kernel:           ${KERNEL}"
echo "Architecture:     ${ARCH}"
echo "Current Shell:    ${CURRENT_SHELL}"
echo "Uptime:           ${UPTIME}"
echo "CPU Model:        ${CPU}"
echo "CPU Cores:        ${CPU_CORES}"
echo "Memory:           ${MEMORY_USED}MB / ${MEMORY_TOTAL}MB"
echo "Disk Usage:       ${DISK_USAGE}%"
echo "IP Address:       ${IP_ADDRESS}"
echo "-----------------------------------------"
echo "System Health:"
echo "-----------------------------------------"
if [ "$MEMORY_PERCENT" -gt 80 ]; then
    echo "MEMORY ALERT! Usage is ${MEMORY_PERCENT}%"
else
    echo "Memory OK"
fi
if (( $(echo "$CPU_LOAD > 2" | bc -l) )); then
    echo "CPU ALERT!"
else
    echo "CPU OK"
fi
if [ "$DISK_USAGE" -gt 80 ]; then
    echo "Disk Status: OK"
fi
if [ "$DISK_PERCENT" -gt 85 ]; then
    echo "DISK ALERT! Usage is ${DISK_PERCENT}%"
else
    echo "Disk OK"
fi
echo "-----------------------------------------"
echo
echo "Generated at: ${GENERATED}"
echo "========================================="


