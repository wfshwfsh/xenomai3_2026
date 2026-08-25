#!/bin/bash

DIR_TOP="$(pwd)"
DIR_LINUX="$DIR_TOP/linux-dovetail"
DIR_ECAT="$DIR_TOP/ethercat"


cd $DIR_ECAT
autoupdate
./bootstrap

configure_modules="--enable-wildcards=yes --disable-generic --disable-8139too --enable-igb --enable-igc --enable-e1000e"
configure_option="--enable-rtdm=yes --with-xenomai-dir=/usr/xenomai"
configure_cmd="./configure --prefix=/usr/local --with-linux-dir=$DIR_LINUX --with-module-dir=/kernel/drivers/ethercat"
configure_cmd="$configure_cmd $configure_option $configure_modules"


echo "configure_cmd: $configure_cmd"
eval $configure_cmd

### copy kernel modules to here
echo "#### ECAT: make modules ####"
make modules

echo "#### ECAT: make install ####"
#make DESTDIR=$DIR_ECAT/dist install
sudo make install

echo "#### ECAT: make module_install ####"
#make INSTALL_MOD_PATH=$DIR_ECAT/dist modules_install
sudo make modules_install

