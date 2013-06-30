#!/bin/bash
#
# requires:
#  bash
#  chroot
#
set -x
set -e

echo "doing execscript.sh: $1"

lxc_version=0.9.0

## root

rsync -avx \
 ${1}/home/${devel_user}/rpmbuild/RPMS/*/lxc-${lxc_version}*.rpm \
 ${1}/home/${devel_user}/rpmbuild/RPMS/*/lxc-*-${lxc_version}*.rpm \
 ./.
