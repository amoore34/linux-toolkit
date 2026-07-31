#!/bin/bash

VERSION="0.1.0"

echo "Linux Toolkit System Monitor v$VERSION"
echo "---------------------"

# Print hostname
HOST_NAME=$(hostname)
echo "Hostname: $HOST_NAME"

# Print date and time
DATE_TIME=$(date)
echo "Time: $DATE_TIME"

# System uptime
echo "Uptime Output"
uptime

# CPU load
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
echo "CPU Load: $CPU_LOAD"

# Memory usage
MEMORY_USED=$(free -m | awk '/Mem:/ {print $3}')
MEMORY_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEMORY_PERCENT=$(( MEMORY_USED * 100 / MEMORY_TOTAL ))

echo "Memory Used: ${MEMORY_USED}MB / ${MEMORY_TOTAL}MB"
echo "Memory Usage: ${MEMORY_PERCENT}%"

if [ "$MEMORY_PERCENT" -gt 80 ]; then
    echo "MEMORY ALERT! Usage is ${MEMORY_PERCENT}%"
else
    echo "Memory OK"
fi

# Disk usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Disk Usage: $DISK_USAGE"

# CPU alert
if (( $(echo "$CPU_LOAD > 2" | bc -l) )); then
    echo "CPU ALERT!"
else
    echo "CPU OK"
fi

# Disk alert
if [ "$DISK_PERCENT" -gt 85 ]; then
    echo "DISK ALERT! Usage is ${DISK_PERCENT}%"
else
    echo "Disk OK"
fi

echo "---------------------"