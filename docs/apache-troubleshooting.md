# Apache Troubleshooting

## Overview

This document contains troubleshooting steps and resolutions encountered while configuring Apache HTTP Server on the Linux development server.

---

## Issue

Apache would not start after configuring SSL.

---

## Error Message

AH00526: Syntax error on line 5 of /etc/httpd/conf.d/ssl.conf:
Cannot define multiple Listeners on the same IP:port

---

## Root Cause

A test configuration file (`ssl-test.conf`) defined an additional `Listen 443` directive and loaded the SSL module a second time.

Apache attempted to bind to port 443 twice, preventing the service from starting.

---

## Troubleshooting Process

1. Checked Apache service status.
2. Validated the configuration with `apachectl -t`.
3. Located duplicate `Listen` directives.
4. Identified `ssl-test.conf` as the duplicate configuration.
5. Disabled the test configuration.
6. Removed duplicate `LoadModule ssl_module`.
7. Configured the `ServerName` directive.
8. Reloaded Apache and verified successful startup.

---

## Commands Used

```bash
sudo systemctl status httpd
sudo apachectl -t
grep -R "^Listen" /etc/httpd
grep -R "LoadModule ssl_module" /etc/httpd
sudo systemctl reload httpd
