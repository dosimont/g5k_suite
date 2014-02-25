#!/bin/bash
useradd -m -g rdma mpi -d /var/mpi
echo "* hard memlock unlimited" >> /etc/security/limits.conf
echo "* soft memlock unlimited" >> /etc/security/limits.conf
mkdir ~mpi/.ssh
cp ~/.ssh/authorized_keys ~mpi/.ssh
chown -R mpi ~mpi/.ssh
cp -r mpi_tools ~mpi/mpi_tools
su - mpi
mkdir src
ssh-keygen -N "" -P "" -f /var/mpi/.ssh/id_rsa
cat .ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo "        StrictHostKeyChecking no" >> ~/.ssh/config
tgz-g5k /dev/shm/image.tgz


