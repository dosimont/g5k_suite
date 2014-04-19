#!/bin/bash
G5K=

OPENMPI=openmpi-1.6.5
SCOREP=scorep-1.2.2
OPARI2=opari2-1.1.1
CUBE4=cube-4.2.1

function inst
{
./configure $@ &&
make -j8 all &&
make install &&
make clean
}

function tarins
{
cd $1 &&
shift 1
inst $@ &&
cd ..
}

function aky
{
cd akypuera &&
mkdir -p build &&
cd build &&
cmake -DOTF2=ON -DOTF2_PATH=/opt/scorep/ .. &&
make &&
make install &&
make clean &&
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
make clean &&
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
make clean &&
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
if [ $G5K ]
then
apt-get update &&
apt-get install libotf-trace-dev &&
apt-get install zlib1g-dev &&
apt-get install libbfd-dev &&
apt-get install gfortran &&
apt-get install cmake &&
apt-get install build-essential libqt4-dev libboost-dev freeglut3-dev
else
yum update
yum install libotf-devel &&
yum install zlib-devel &&
yum install binutils-devel &&
yum install gcc-gfortran &&
yum install cmake &&
yum install cmake gcc gcc-c++ qt-devel boost-devel freeglut-devel &&
yum groupinstall "Development Tools"
fi
tarins $OPENMPI
tarins $OPARI2 --prefix=/opt/opari2
tarins $CUBE4 --prefix=/opt/cube4
tarins $SCOREP --prefix=/opt/scorep --with-opari2=/opt/opari2 --with-cube=/opt/cube4
rm -fr $OPENMPI $OPARI2 $CUBE4 $SCOREP
if [ ! $G5K ]
then
aky
poti
cp /usr/local/lib/libpoti.so.4.2 /usr/local/lib/libpoti.so.2
pajeng
fi

cd ..
if [ $G5K ]
then
tgz-g5k image.tgz
fi

