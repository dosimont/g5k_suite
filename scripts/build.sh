#!/bin/bash

function inst
{
./configure &&
make all install
}

function tarins
{
cd $1 &&
inst &&
cd ..
}

function aky
{
mkdir -p akypuera/build &&
cd akypuera/build &&
cmake -DOTF2=ON -DOTF2_PATH=/opt/scorep/ .. &&
make &&
make install &&
cd ../..
}

function poti
{
cd poti &&
mkdir -p build &&
cd build &&
cmake .. &&
make &&
make install &&
cd ../..
}

cd mpi_tools &&
for i in `ls *tar.gz`
do
tar xzf $i
done
if grep -q "/usr/local/lib" /etc/ld.so.conf
then
echo "library path already defined"
else
echo "define library path"
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig
fi
apt-get update &&
apt-get install libotf-trace-dev &&
apt-get install zlib1g-dev &&
apt-get install libbfd-dev &&
apt-get install gfortran &&
apt-get install cmake &&
tarins openmpi-1.6.5
tarins scorep-1.0.2
aky
poti

cd ..

useradd -m -g rdma mpi -d /var/mpi
echo "* hard memlock unlimited" >> /etc/security/limits.conf
echo "* soft memlock unlimited" >> /etc/security/limits.conf
mkdir ~mpi/.ssh
cp ~/.ssh/authorized_keys ~mpi/.ssh
chown -R mpi ~mpi/.ssh
su -c 'ssh-keygen -N "" -P "" -f /var/mpi/.ssh/id_rsa && cat .ssh/id_rsa.pub >> ~/.ssh/authorized_keys && echo "        StrictHostKeyChecking no" >> ~/.ssh/config' - mpi
cp -r mpi_tools ~mpi/
cp .bashrc ~mpi/
mkdir ~mpi/bin
mkdir ~mpi/scripts
cp mvbin.sh ~mpi/scripts/
chown -R mpi ~mpi/*
tgz-g5k /dev/shm/image.tgz


