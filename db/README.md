README
======

Warning!
--------

Don't install if you are already running a postgres database on your machine, or if you have a folder called data in the folder you are in. Follow instructions carefully.

Initializing the database
-------------------------

1. Create a file named "pw". In the first line, enter what you want your password for the admin user to be.
1. Run install.sh <folder> <database> <user>
1. Delete the password file if you like.
1. Done!

What did I just do?
-------------------

1. You created the postgres environement, the cluster, the big shebang. And it is all in that folder called
1. You created a user `dbadmin`, with the password you put in that pw file.
1. You created some tables with values and associations.
