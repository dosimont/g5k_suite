#!/bin/bash

SITE=$1
rsync -avzr --del ../../g5k_suite/ $1.g5k:~/g5k_suite

