#!/bin/bash
NODES=$1
shift
H=$1
shift
M="00"
if [ $# -eq 2 ]
then
M=$1
shift
fi
R=$1

oarsub -l nodes=$NODES,walltime=$H:$M -r "$1" -t deploy
