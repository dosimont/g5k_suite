#!/bin/bash

mkdir -p $HOME/public
scp root@`head -1 $OAR_NODEFILE`:~/image.tgz $HOME/public/wheezy-dosi.tgz
grep -v visibility /grid5000/descriptions/wheezy-x64-big-1.1.dsc > $HOME/public/wheezy-dosi.dsc
perl -i -pe "s@/grid5000/images/wheezy-x64-big-1.1.tgz@http://public.$(hostname | cut -d. -f2).grid5000.fr/~$USER/wheezy-dosi.tgz@" $HOME/public/wheezy-dosi.dsc
wget -qO - http://public.nancy.grid5000.fr/~kjenkins/kaenv_migration  | ruby1.8 - $HOME/public/wheezy-dosi.dsc  > $HOME/public/wheezy-dosi.yml


