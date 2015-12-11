Chalmers Post(greSQL) Grades
======
Postgres database of all grade statistics at Chalmers University of Technology since fall 2011.

Warning
-------

If there is an existing database running in the specified folder (first argument), it will be deleted.

Initializing the database
-------------------------

Run install.sh <folder-where-you-want-the-databast> <database-name>

What did I just do?
-------------------

If there was an existing server running in the specified folder, you removed it and stopped it.

1. You created the postgres environement, the cluster, the big shebang. And it is all in that folder you wanted
1. You created a user with a password.
1. You imported all the Chalmers grades data into the database.
