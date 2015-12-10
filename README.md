Chalmers Post(greSQL) Grades
======
Postgres database of all grade statistics at Chalmers University of Technology since fall 2011.

Warning!
--------

Don't install if you are already running a postgres database on your machine, or if you have a folder called data in the folder you are in. Follow instructions carefully.

Initializing the database
-------------------------

Run install.sh <folder-where-you-want-the-databast> <database-name>

What did I just do?
-------------------

1. You created the postgres environement, the cluster, the big shebang. And it is all in that folder you wanted
1. You created a user with a password.
1. You imported all the Chalmers grades data into the database.
