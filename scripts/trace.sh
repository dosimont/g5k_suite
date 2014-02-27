#!/bin/sh -x
NODE=`head -n 1 $OAR_NODE_FILE |cut -d"." -f1`
SSH="mpi@$NODE"
SCP="$SSH:~"
res=~/results/$1
mkdir -p $res
scp -r $SCP/bin/* $res
sshserver="abenaki.grenoble"
echo
echo "Processing trace backup"
echo "------------------------------------"
echo "Creating new directory"
da=`date '+%Y.%m.%d'`
ssh $sshserver 'bash -c "mkdir -p data/traces/$(date '+%Y.%m.%d'); mkdir -p data/traces/$(date '+%Y.%m.%d')/unsorted"'
  scp -r $res/* $sshserver:data/traces/$da/
echo "Directory saved in data/traces/$da/ directory"
exit 0
