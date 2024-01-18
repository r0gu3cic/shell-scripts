#!/bin/bash

local_backup_directory="</path/to/the/local/backup/directory/>"
do_space="<name of the DigitalOcean space used for storing backup>"
username="<username of the user which will connect to the db you want to backup>"
db_name="<db name of the db you want to backup>"
timestamp=$(date +%Y-%m-%d)
# Database dump, this script expect that you have .pgpass configured on a server
dbdump(){
    printf "\n##### Dumping DB to %s%s-db.bak #####\n" "$local_backup_directory" "$timestamp"
    pg_dump -h localhost -p 5432 -U "$username" -v -b -F c -f "$local_backup_directory$timestamp-db.bak" -d "$db_name"
    printf "\n##### Done dumping DB #####\n"
}

# Sending db backup to the DigitalOcean Space, this script expects that you have s3cmd configured on your server (.s3cfg)
movetospace(){
    printf "\n##### Moving backup to space #####\n"
    s3cmd put "$local_backup_directory$timestamp-db.bak" s3://"$do_space"/
    # I used to run the script using the command ./backup_script.sh > /home/user/backup/$(date +%Y-%m-%d)-backup-log.txt 2>&1
    s3cmd put "$local_backup_directory$timestamp-backup-log.txt" s3://"$do_space"/
    printf "\n##### Done moving backup to s3://%s/ #####\n" "$do_space"
}

# Cleaning up local backups, delete backups and log files older than 3 days
cleanup(){
    printf "\n##### Deleting old files except backup and log.txt #####\n"
    find "$local_backup_directory" -type f -mtime +3 -delete
    printf "\n##### Done cleanup process #####\n"
}

printf "\n##### Starting backup process #####\n"
dbdump
movetospace
cleanup
printf "\n##### The backup process was successfully done #####\n"