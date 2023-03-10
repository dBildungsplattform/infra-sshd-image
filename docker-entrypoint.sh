#!/usr/bin/env bash

# Generate host keys if missing
ssh-keygen -A

/usr/sbin/sshd -D -e
