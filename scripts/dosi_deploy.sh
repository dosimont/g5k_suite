#!/bin/bash


cat $OAR_NODE_FILE > nodes
cat nodes | sort -u > unodes
kadeploy3 -f $OAR_NODE_FILE -a $HOME/public/wheezy-dosi.dsc -k
