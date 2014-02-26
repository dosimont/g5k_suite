#!/bin/bash


cat $OAR_NODE_FILE > nodes
cat nodes | sort -u > unodes
kadeploy3 -f $OAR_NODE_FILE -e wheezy-x64-base -k

NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="root@$NODE"
SCP="$SSH:~"
echo "copying files to $SSH"
scp -r ../mpi_tools $SCP
scp build.sh $SCP
scp mvbin.sh $SCP
scp nodes $SCP
scp bashrc $SCP/.bashrc
ssh $SSH

