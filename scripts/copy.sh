#!/bin/bash


NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="root@$NODE"
SCP="$SSH:~"
echo "copying files to $SSH"
scp -r ../mpi_tools $SCP
scp config.sh $SCP
scp .bashrc $SCP

