#!/bin/bash
USERNAME=$1
HOSTNAME=$2
USERPASSWORD=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 8 | xargs)
EXISTINGUSER=0
EXISTFLAG=0

EXISTINGUSER=$(ssh root@$HOSTNAME "ls -l /home | grep $USERNAME -c")
if (($EXISTINGUSER==$EXISTFLAG))
then
	ssh root@$HOSTNAME "useradd -p change_me! -s /bin/bash $USERNAME; mkdir /home/$USERNAME/.ssh"
	scp /home/alex/bin/user_add/$USERNAME root@$HOSTNAME:/home/$USERNAME/.ssh/authorized_keys
	ssh root@$HOSTNAME "chown -R $USERNAME:$USERNAME /home/$USERNAME/; chmod 700 /home/$USERNAME/.ssh; chmod 600 /home/$USERNAME/.ssh/authorized_keys; chmod 755 /home/$USERNAME; echo $USERPASSWORD | passwd --stdin $USERNAME"
	#echo "$USERNAME:USERPASSWORD" | chpasswd
	echo login ":" $USERNAME " | " password ":" $USERPASSWORD
	echo login ":" $USERNAME " | " password ":" $USERPASSWORD " | " Server ":"$HOSTNAME " | " date ":" $(date) >> /home/alex/bin/user_add/adduser.log
else
	echo User already exists, operation canceled !
fi
