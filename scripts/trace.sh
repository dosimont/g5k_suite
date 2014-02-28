#!/bin/sh -x
sshserver="abenaki.grenoble"
echo
echo "Processing trace backup"
echo "------------------------------------"
echo "Creating new directory"
da=`date '+%Y.%m.%d'`
ssh $sshserver 'bash -c "mkdir -p data/traces/$(date '+%Y.%m.%d'); mkdir -p data/traces/$(date '+%Y.%m.%d')/unsorted"'
if [ -f "$1" ]
then
  mv $1 $2
  scp $2 $sshserver:data/traces/$da/unsorted
echo "File saved in data/traces/$da/unsorted directory"
elif [ -d "$1" ]
then
  mv $1 $2
  cp ~/nodes $2/
  scp -r $2 $sshserver:data/traces/$da/
echo "Directory saved in data/traces/$da/ directory"
else
  echo "No file uploaded"
fi
exit 0
