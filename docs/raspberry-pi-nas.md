# Raspberry Pi NAS

## Overview

This project documents building a Network Attached Storage (NAS) using a Raspberry Pi. The goal was to create centralized storage for backups, media, and project files that could be accessed from multiple devices on the local network.

## Objectives

- Build a Linux-based NAS
- Configure shared storage
- Access files from macOS and Windows
- Learn Linux storage management
- Explore self-hosted services

## Environment

### Hardware

- Raspberry Pi 500
- 2 TB SSD
- External USB storage

### Operating System

- Debian 12

## Skills Learned

- Disk management
- File systems
- Mounting drives
- SMB file sharing
- Linux permissions
- SSH
- Network storage

## Topics Covered

- Installing Debian on Raspberry Pi
- Preparing and formatting storage devices
- Mounting drives and configuring `/etc/fstab`
- Configuring SMB file sharing
- Accessing shares from macOS Finder
- Accessing shares from Windows
- Setting up Nextcloud
- Using `rsync` for backups
- Backing up a Mac over the network
- Formatting exFAT drives for cross-platform compatibility
- Managing external SSDs and HDDs
- Troubleshooting storage, permissions, and network issues

## Lessons Learned

This project evolved far beyond a simple NAS. Along the way, I learned Linux storage management, SMB file sharing, drive formatting, backup strategies, and remote administration. It also became the foundation for protecting data across my Raspberry Pi, Mac, and other systems while exploring self-hosted services such as Nextcloud.

## Future Improvements

- Add screenshots
- Document drive layout
- Include configuration files
- Add backup automation
- Document recovery procedures
