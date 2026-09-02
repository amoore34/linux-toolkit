#!/bin/bash

# ------------------------------------------------------------
# Linux Toolkit
# Script: system-info.sh
# Version: 1.2.0
# Author: Amber Moore
# Description: Displays system information and performs basic
#              health checks.
# ------------------------------------------------------------

VERSION="1.2.0"

# Colors
GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

CHECK="${GREEN}✔${RESET}"
WARNING="${RED}✘${RESET}"

# ------------------------------------------------------------
# Help Menu
# ------------------------------------------------------------

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Linux Toolkit System Information"
    echo
    echo "Usage:"
    echo "    system-info.sh"
    echo
    echo "Description:"
    echo "    Displays:"
    echo "      • Hostname"
    echo "      • Operating System"
    echo "      • Current User"
    echo "      • Kernel Version"
    echo "      • Architecture"
    echo "      • Current Shell"
    echo "      • CPU Information"
    echo "      • Memory Usage"
    echo "      • Disk Usage"
    echo "      • IP Address"
    echo "      • System Uptime"
    echo "      • Basic Health Checks"
    exit 0
fi

# ------------------------------------------------------------
# Gather System Information
# ------------------------------------------------------------

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
OS=$(grep "^PRETTY_NAME=" /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
ARCH=$(uname -m)
CURRENT_SHELL=$(basename "$SHELL")
UPTIME=$(uptime -p)
CPU=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
CPU_CORES=$(nproc)
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)

MEMORY_USED=$(free -m | awk '/Mem:/ {print $3}')
MEMORY_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEMORY_PERCENT=$(( MEMORY_USED * 100 / MEMORY_TOTAL ))

DISK_PERCENT=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

IP_ADDRESS=$(hostname -I | awk '{print $1}')

GENERATED=$(date)

# ------------------------------------------------------------
# Header
# ------------------------------------------------------------

echo -e "${GREEN}${BOLD}"
echo "================================================"
echo "Linux Toolkit System Information v$VERSION"
echo "================================================"
echo -e "${RESET}"

# ------------------------------------------------------------
# System Information
# ------------------------------------------------------------

printf "%-18s %s\n" "Hostname:" "$HOSTNAME"
printf "%-18s %s\n" "Operating System:" "$OS"
printf "%-18s %s\n" "Current User:" "$CURRENT_USER"
printf "%-18s %s\n" "Kernel:" "$KERNEL"
printf "%-18s %s\n" "Architecture:" "$ARCH"
printf "%-18s %s\n" "Current Shell:" "$CURRENT_SHELL"
printf "%-18s %s\n" "Uptime:" "$UPTIME"
printf "%-18s %s\n" "CPU Model:" "$CPU"
printf "%-18s %s\n" "CPU Cores:" "$CPU_CORES"
printf "%-18s %s\n" "CPU Load:" "$CPU_LOAD"
printf "%-18s %sMB / %sMB\n" "Memory:" "$MEMORY_USED" "$MEMORY_TOTAL"
printf "%-18s %s%%\n" "Disk Usage:" "$DISK_PERCENT"
printf "%-18s %s\n" "IP Address:" "$IP_ADDRESS"

echo

echo -e "${BLUE}"
echo "----------------------------------------"
echo "System Health"
echo "----------------------------------------"
echo -e "${RESET}"

# ------------------------------------------------------------
# Memory Check
# ------------------------------------------------------------

if [ "$MEMORY_PERCENT" -gt 80 ]; then
    echo -e "Memory Status     ${WARNING}  ${RED}${MEMORY_PERCENT}% Used${RESET}"
else
    echo -e "Memory Status     ${CHECK}"
fi

# ------------------------------------------------------------
# CPU Check
# ------------------------------------------------------------

if (( $(echo "$CPU_LOAD > 2" | bc -l) )); then
    echo -e "CPU Status        ${WARNING}  ${RED}Load: ${CPU_LOAD}${RESET}"
else
    echo -e "CPU Status        ${CHECK}"
fi

# ------------------------------------------------------------
# Disk Check
# ------------------------------------------------------------

if [ "$DISK_PERCENT" -gt 85 ]; then
    echo -e "Disk Status       ${WARNING}  ${RED}${DISK_PERCENT}% Used${RESET}"
else
    echo -e "Disk Status       ${CHECK}"
fi

echo
echo -e "${CYAN}Generated at:${RESET} $GENERATED"

echo
echo "================================================"

exit 0