#!/bin/bash

NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="$NODE"
SCP="$SSH:~"
ssh $SSH

