#!/bin/bash

function inst
{
./configure &&
make -j8 all &&
make install
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

function pajeng
{
cd pajeng &&
mkdir -p build &&
cd build &&
cmake -DPAJENG=OFF \
      -DPJ_DUMP=ON \
      -DPJ_VALIDATE=ON \
      -DPAJE_UTILS_LIBRARY=OFF \
      -DPAJE_LIBRARY=ON .. &&
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
apt-get install build-essential libqt4-dev libboost-dev freeglut3-dev &&
tarins openmpi-1.6.5
tarins scorep-1.0.2
aky
poti
cp /usr/local/lib/libpoti.so.4.2 /usr/local/lib/libpoti.so.2
pajeng


cd ..

tgz-g5k image.tgz


