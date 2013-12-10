#!/bin/bash


NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="root@$NODE"
SCP="$SSH:~"
echo "connecting to $SSH"
ssh $SSH

