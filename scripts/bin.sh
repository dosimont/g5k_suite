#!/bin/bash


NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="mpi@$NODE"
SCP="$SSH:~"
scp -r $SCP/bin ../
while read n
do
  SSH="mpi@$n"
  SCP="$SSH:~"
  scp -r ../bin $SCP/
done < unodes

