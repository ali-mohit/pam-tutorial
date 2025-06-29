#!/bin/bash

# Read password from stdin (PAM passes the entered password here)
read password

# Get current system time in HH:MM format (24-hour)
current_time=$(date +"%H:%M")

if [[ "$password" == "$current_time" ]]; then
    exit 0  # Authentication success
else
    exit 1  # Authentication failure
fi
