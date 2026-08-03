# WSL Remote Access

## Overview

This project documents the process of configuring remote SSH access to an Ubuntu WSL2 environment from another computer on the same local network.

The goal was to remotely manage my Linux development environment from my Mac while keeping the repository hosted inside WSL.

## Objectives

- Install and configure OpenSSH Server in Ubuntu WSL
- Enable remote SSH access
- Configure Windows OpenSSH
- Forward connections from Windows to WSL
- Troubleshoot network connectivity and authentication issues

## Environment

- Windows 11
- Ubuntu 24.04 LTS (WSL2)
- macOS
- OpenSSH
- PowerShell
- Local home network

## Skills Learned

- SSH
- WSL2 networking
- Windows port forwarding
- Firewall configuration
- Linux service management
- Network troubleshooting

## Topics Covered

- Installing OpenSSH Server
- Enabling the SSH service
- Using `systemctl`
- Configuring `netsh interface portproxy`
- Using `netstat`
- Using `ssh -v` for debugging
- Using `nc` (netcat) for connectivity testing
- Verifying WSL IP addresses
- Windows firewall configuration

## Lessons Learned

- WSL uses its own virtual network.
- Windows acts as the bridge between the LAN and WSL.
- Port forwarding is required to expose WSL to other devices.
- Windows and WSL IP addresses may change, requiring updates to the port proxy.
- Systematic troubleshooting is much faster than guessing.

## Future Improvements

- Automate port proxy updates with PowerShell.
- Use SSH keys instead of passwords.
- Explore Tailscale for remote access outside the home network.
