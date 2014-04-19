#!/bin/bash

SITE=$1
rsync -avzr --del ../../g5k_suite/scripts/ $1.g5k:~/g5k_suite/scripts
scp bashrc $1.g5k:~/.bashrc
