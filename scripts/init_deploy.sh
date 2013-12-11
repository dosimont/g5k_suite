#!/bin/bash


cat $OAR_NODE_FILE > nodes
kadeploy3 -f $OAR_NODE_FILE -e wheezy-x64-base -k
