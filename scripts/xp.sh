#!/bin/bash

cat $OAR_NODE_FILE > ~/nodes
cat ~/nodes | sort -u > ~/unodes
kadeploy3 -f $OAR_NODE_FILE -a $HOME/public/wheezy-dosi.dsc -k

NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="$NODE"
SCP="$SSH:~"
cp bashrc ~/.bashrc
ssh $SSH

