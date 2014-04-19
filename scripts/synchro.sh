#!/bin/bash

for site in $@
do
rsync -avzr --del ~/ $site.g5k:~
done
