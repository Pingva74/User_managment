#!/bin/bash
USERNAME=$1
HOSTNAME=$2
PORT=$3
USERPASSWORD=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 8 | xargs)
EXISTINGUSER=0
EXISTFLAG=0

EXISTINGUSER=$(ssh -p $PORT root@$HOSTNAME "ls -l /home | grep $USERNAME -c")
if (($EXISTINGUSER==$EXISTFLAG))
then
	ssh -p 60022 root@$HOSTNAME "useradd -p change_me! -s /bin/bash $USERNAME; mkdir /home/$USERNAME/.ssh"
	scp -P 60022 /home/alex/bin/user_add/$USERNAME root@$HOSTNAME:/home/$USERNAME/.ssh/authorized_keys
	ssh -p 60022 root@$HOSTNAME "chown -R $USERNAME:$USERNAME /home/$USERNAME/; chmod 700 /home/$USERNAME/.ssh; chmod 600 /home/$USERNAME/.ssh/authorized_keys; chmod 755 /home/$USERNAME; echo $USERPASSWORD | passwd --stdin $USERNAME"
	#echo "$USERNAME:USERPASSWORD" | chpasswd
	echo login ":" $USERNAME " | " password ":" $USERPASSWORD
	echo login ":" $USERNAME " | " password ":" $USERPASSWORD " | " Server ":"$HOSTNAME " | " date ":" $(date) >> /home/alex/bin/user_add/adduser.log
else
	echo User already exists, operation canceled !
fi
