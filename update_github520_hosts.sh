#!/bin/bash

# Define markers for the start and end of the GitHub520 hosts content
START_MARKER="# Update_GitHub520_Host_START_MARKER"
END_MARKER="# Update_GitHub520_Host_END_MARKER"

# The URL from where to download the hosts file
HOSTS_URL="https://raw.hellogithub.com/hosts"

# Temporary file to store the downloaded hosts content
TMP_HOSTS="/tmp/github520_hosts"

# Backup the current /etc/hosts file
cp /etc/hosts /etc/hosts.backup.$(date +%F-%H%M%S)

# Download the latest GitHub520 hosts file
curl -o $TMP_HOSTS $HOSTS_URL

# Check if the download was successful
if [ $? -eq 0 ]; then
    # Replace the old GitHub520 hosts section with the new downloaded content
    
    # On macOS, use '' with -i to edit in-place without creating a backup
    # Use .bak to create a backup file
    sed -i '' "/$START_MARKER/,/$END_MARKER/d" /etc/hosts
    
    # Append the new GitHub520 hosts
    {
        echo "$START_MARKER"
        cat $TMP_HOSTS
        echo "$END_MARKER"
    } >> /etc/hosts

    echo "GitHub520 hosts content has been updated."
else
    echo "Failed to download the GitHub520 hosts file."
    exit 1
fi

# Clean up the temporary file
rm -f $TMP_HOSTS
