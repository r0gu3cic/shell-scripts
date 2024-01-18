# Useful shell scripts

This is a collection of scripts that I used for some tasks.  

## Usage

Run the script that you like/need, make sure to check the variables first before running, and make sure that the script is executable :smiley:

## Short explanations

### gzip-log-files-and-store-them.sh

This script should check the directory for log files, gzip them, and move them to the other directory intended for keeping the logs.

### pg-dump-backup-and-move-backup-cloud.sh

This script should create a backup of a specific PostgreSQL database and upload that backup and log file about that backup to the cloud, after that, the script should check the local backup directory for any backups or logs older than 3 days and remove them.  
This script was used for automated backups, script expects to run on a server which has configured PostgreSQL server (.pgpass) and s3cmd tool (.s3cmd).
