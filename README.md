# User_managment


Script to add users to a remote server.

Create a file with the name of the user being added. Add the public key of the future user to the file.

Run the script with the following command: adduser_to_host.sh user 192.168.0.115

Where user is the name of the file with the public key, 192.168.0.115 is the address or domain name of the remote host

The script will create a user, register its public key, give you a user name, password, host address and the date the user is created in the log file.


