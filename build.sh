#!/usr/bin/env bash

set -e

ARCH=$1

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential gcc-10 g++-10 gnat-10 wget file cpio unzip rsync bc python3

BUILDROOT_VER=buildroot-2020.08.2
wget --progress=dot https://buildroot.org/downloads/$BUILDROOT_VER.tar.gz -O buildroot.tar.gz
tar xvf buildroot.tar.gz
pushd $BUILDROOT_VER
cp -f ../$ARCH.config .config
make HOSTCC=gcc-10 HOSTCXX=g++-10 -j`nproc` sdk
popd

mv $BUILDROOT_VER/output/images/${CROSS_TRIPLE}_sdk-buildroot.tar.gz buildroot_$ARCH.tar.gz
