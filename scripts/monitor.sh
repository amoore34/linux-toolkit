#!/bin/bash
echo "System Monitor Script"
echo "---------------------"

# print Hostname: <machine>
HOST_NAME=$(hostname)
echo "Hostname: $HOST_NAME"

# print Date:
DATE_TIME=$(date)
echo "Time: $DATE_TIME"

echo "Uptime Output"
uptime

# /proc/loadavg
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
echo "CPU load: $CPU_LOAD"

# free -m
MEMORY_USED=$(free -m | awk '/Mem:/ {print $3}')
MEMORY_TOTAL=$(free -m | awk '/Mem:/ {print $2}')

echo "Memory Used: ${MEMORY_USED}MB / ${MEMORY_TOTAL}MB"

MEMORY_PERCENT=$(( MEMORY_USED * 100 / MEMORY_TOTAL ))

echo "Memory Usage: ${MEMORY_PERCENT}%"

echo "New code added"

if [ "$MEMORY_PERCENT" -gt 80 ]
then
	echo "MEMORY ALERT! Usage is ${MEMORY_PERCENT}%"
else
	echo "Memory OK"
fi

# df -h
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
DSK_USAGE=$(df -h / | awk 'NR==2 {gsub("%", ""); print $5}')
echo "Disk Usage: $DISK_USAGE"
echo "NEW Disk Usage: $DSK_USAGE"

# print  Alert for CPU
if (( $(echo "$CPU_LOAD > 2" | bc -l) ))
then
	echo "CPU ALERT!"
else 
	echo "CPU OK"
fi

echo "New code added"
if [ "$DSK_USAGE" -gt 85 ]
then 
	echo "DISK ALERT! Usage is ${DSK_USAGE}%"
else
	echo "Disk OK"
fi

echo "--------------------"
