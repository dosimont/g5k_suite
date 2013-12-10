#!/bin/bash
NODES=$1
H=$2
M="00"
if [ $3 ]
then
M=$3
fi

oarsub -I -l nodes=$NODES,walltime=$H:$M -t deploy
