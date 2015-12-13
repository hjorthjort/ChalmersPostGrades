#!/bin/bash

# install.sh directory databasename username

# Terminate ongoing processes
pg_ctl -w -D "$1" stop

# If there is a dir or file with the name we want for our datadir, delete it and create it again.
rm -rf "$1"
mkdir "$1"

# Remove existing gitignore
rm -f .gitignore

# Ignore database files
printf ".gitignore\n" >> .gitignore
printf "\n#Database directory\n$1\n" >> .gitignore 
printf "\n#Password file\n.password\n" >> .gitignore

# Set postgresuser
printf "Enter username: "
read line
user="$line"
export PGUSER="$user"

# Get a password, store in variable $line, store in password file
rm -f .password
printf "Enter password: "
read -s line
password="$line"
printf "$password" > .password
chmod 600 .password

# Create database
initdb -D "$1" --username="$user" --pwfile=.password

# Start the server and wait for it to start before proceeding (-w flag)
pg_ctl -w -D "$1" -l "$1"/logfile start

# Create the new user on the server
createuser -s "$user"

# Create new db
createdb -U "$user" "$1"/"$2"

# Replace tokens in init_db.sql with correct values
sed 's:--WORKINGDIR--:'`pwd`':' <init_db.sql > tmp_init_db.sql

# Initiate based on an init file
psql -U "$user" --file=tmp_init_db.sql "$1"/"$2"

# Remove temp file
rm -f tmp_init_db.sql

# Give user some instructions
printf "\nDatabase created successfully! run \n\n\tpsql %s/%s %s\n\n to start using it\n" "$1" "$2" "$user"
