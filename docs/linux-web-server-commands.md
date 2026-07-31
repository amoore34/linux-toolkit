# Linux Web Server Commands

> This document will be updated as I regain access to the original virtual machine.

## Connecting to the Server

```bash
ssh username@server-ip
```

## Updating the System

```bash
sudo apt update
sudo apt upgrade
```

## Installing Apache

```bash
sudo apt install apache2
```

## Managing the Apache Service

```bash
sudo systemctl start apache2
sudo systemctl stop apache2
sudo systemctl restart apache2
sudo systemctl status apache2
sudo systemctl enable apache2
```

## Firewall

```bash
sudo ufw allow "Apache"
```

## Website Files

```bash
cd /var/www/html
ls
```

## Notes

This document is intentionally incomplete. It will be expanded with the exact commands, configuration files, screenshots, and explanations once access to the original virtual machine is restored.
