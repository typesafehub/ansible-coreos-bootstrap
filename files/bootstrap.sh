#/bin/bash

set -e

cd

if [[ -e /home/lightbend/pypy/bin/pypy ]]; then
  exit 0
fi

PYPY_VERSION=3.5-5.7.1-beta
pypy3.5-5.7.1-beta-linux_x86_64-portable.tar.bz2
if [[ -e $HOME/pypy$PYPY_VERSION-linux_x86_64-portable.tar.bz2 ]]; then
  tar -xjf $HOME/pypy$PYPY_VERSION-linux_x86_64-portable.tar.bz2
#  rm -rf $HOME/pypy$PYPY_VERSION-linux_x86_64-portable.tar.bz2
else
  wget -O - https://bitbucket.org/squeaky/portable-pypy/downloads/pypy$PYPY_VERSION-linux_x86_64-portable.tar.bz2 | tar -xjf -
fi

# remove, because otherwise this version will get placed into a subdir of an existing pypy/
rm -rf pypy
mv -f pypy-$PYPY_VERSION-linux_x86_64-portable /home/lightbend/pypy

## library fixup
mkdir -p /home/lightbend/pypy/lib
ln -snf /lib64/libncurses.so.5.9 /home/lightbend/pypy/lib/libtinfo.so.5

chown -R lightbend /home/lightbend/pypy

/home/lightbend/pypy/bin/pypy --version
/home/lightbend/pypy/bin/pypy -m ensurepip

