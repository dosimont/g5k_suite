#!/bin/bash


cat $OAR_NODE_FILE > ~/nodes
cat ~/nodes | sort -u > ~/unodes
