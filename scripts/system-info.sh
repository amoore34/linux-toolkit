#!/bin/bash

# ------------------------------------------------------------
# Linux Toolkit
# Script: system-info.sh
# Version: 2.0.0
# Author: Amber Moore
# Description: Displays system information and performs
#              basic health checks.
# ------------------------------------------------------------

VERSION="2.0.0"

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

GREEN="\e[38;5;46m"
RED="\e[38;5;196m"
YELLOW="\e[38;5;220m"
CYAN="\e[38;5;51m"
WHITE="\e[97m"
GRAY="\e[38;5;250m"
BOLD="\e[1m"
RESET="\e[0m"

CHECK="${GREEN}✔${RESET}"
WARNING="${YELLOW}⚠${RESET}"
FAIL="${RED}✘${RESET}"

# ------------------------------------------------------------
# Help
# ------------------------------------------------------------

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    cat << EOF

Linux Toolkit System Information v$VERSION

Usage:
    system-info.sh

Displays:

 • Hostname
 • Operating System
 • Current User
 • Kernel
 • Architecture
 • Current Shell
 • CPU Information
 • Memory Usage
 • Disk Usage
 • IP Address
 • System Health

EOF
    exit 0
fi

# ------------------------------------------------------------
# Collect System Information
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

echo
echo -e "${GREEN}${BOLD}"
echo "=========================================================="
echo "        Linux Toolkit System Information"
echo "                 Version $VERSION"
echo "=========================================================="
echo -e "${RESET}"

# ------------------------------------------------------------
# System Information
# ------------------------------------------------------------

printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Hostname:" "$HOSTNAME"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Operating System:" "$OS"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Current User:" "$CURRENT_USER"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Kernel:" "$KERNEL"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Architecture:" "$ARCH"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Current Shell:" "$CURRENT_SHELL"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "Uptime:" "$UPTIME"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "CPU Model:" "$CPU"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "CPU Cores:" "$CPU_CORES"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "CPU Load:" "$CPU_LOAD"
printf "${WHITE}%-18s${RESET} ${GRAY}%sMB / %sMB${RESET}\n" "Memory:" "$MEMORY_USED" "$MEMORY_TOTAL"
printf "${WHITE}%-18s${RESET} ${GRAY}%s%%${RESET}\n" "Disk Usage:" "$DISK_PERCENT"
printf "${WHITE}%-18s${RESET} ${GRAY}%s${RESET}\n" "IP Address:" "$IP_ADDRESS"

echo

# ------------------------------------------------------------
# Health Checks
# ------------------------------------------------------------

echo -e "${CYAN}${BOLD}"
echo "---------------------- System Health ----------------------"
echo -e "${RESET}"

SYSTEM_STATUS="HEALTHY"

# Memory

if [ "$MEMORY_PERCENT" -gt 80 ]; then
    echo -e "Memory Status   $FAIL  ${RED}${MEMORY_PERCENT}% Used${RESET}"
    SYSTEM_STATUS="ATTENTION REQUIRED"
else
    echo -e "Memory Status   $CHECK"
fi

# CPU

CPU_LIMIT=$CPU_CORES

if (( $(echo "$CPU_LOAD > $CPU_LIMIT" | bc -l) )); then
    echo -e "CPU Status      $WARNING  ${YELLOW}High Load (${CPU_LOAD})${RESET}"
    SYSTEM_STATUS="ATTENTION REQUIRED"
else
    echo -e "CPU Status      $CHECK"
fi

# Disk

if [ "$DISK_PERCENT" -gt 85 ]; then
    echo -e "Disk Status     $FAIL  ${RED}${DISK_PERCENT}% Used${RESET}"
    SYSTEM_STATUS="ATTENTION REQUIRED"
else
    echo -e "Disk Status     $CHECK"
fi

echo

# ------------------------------------------------------------
# Overall Status
# ------------------------------------------------------------

echo -e "${CYAN}${BOLD}"
echo "---------------------- Summary ----------------------------"
echo -e "${RESET}"

if [[ "$SYSTEM_STATUS" == "HEALTHY" ]]; then
    echo -e "Overall Status  ${CHECK} ${GREEN}$SYSTEM_STATUS${RESET}"
else
    echo -e "Overall Status  ${WARNING} ${YELLOW}$SYSTEM_STATUS${RESET}"
fi

echo
echo -e "${CYAN}Generated:${RESET} $GENERATED"

echo
echo "=========================================================="

exit 0