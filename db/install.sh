#!/bin/bash

# install.sh directory databasename username

# Terminate ongoing processes
killall postgres

# If there is a dir or file with the name we want for our datadir, delete it and create it again.
rm -rf "$1"
mkdir "$1"
# Set postgresuser
export PGUSER="$3"

# Create the database
initdb -D "$1" --username=dbadmin --pwfile=password

# Start the server and wait for it to start before proceeding (-w flag)
pg_ctl -w -D "$1" -l "$1"/logfile start

# Create new db
createdb -U "$3" "$1"/"$2"

# Initiate based on an init file
psql -U "$3" --file=init_db.sql "$1"/"$2"
