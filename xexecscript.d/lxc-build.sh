#!/bin/bash
#
# requires:
#  bash
#  chroot
#
set -x
set -e

echo "doing execscript.sh: $1"

lxc_version=0.8.0

## root

## normal user

chroot $1 su - ${devel_user} <<EOS
  whoami

  curl -fsSkL -O http://lxc.sourceforge.net/download/lxc/lxc-${lxc_version}.tar.gz
  tar zxvf lxc-${lxc_version}.tar.gz
  cd lxc-${lxc_version}

  # https://lists.linux-foundation.org/pipermail/containers/2013-February/031723.html
  ./configure --disable-apparmor
  args=--disable-apparmor make rpm
EOS

# should install lxc-libs 1st
chroot $1 $SHELL <<EOS
  rpm -ivh /home/${devel_user}/rpmbuild/RPMS/*/lxc-libs-${lxc_version}*.rpm
  rpm -ivh /home/${devel_user}/rpmbuild/RPMS/*/lxc-devel-${lxc_version}*.rpm
  rpm -ivh /home/${devel_user}/rpmbuild/RPMS/*/lxc-${lxc_version}*.rpm
EOS
