#/bin/bash

set -e

cd

if [[ -e /home/lightbend/pypy/bin/pypy ]]; then
  exit 0
fi

PYPY_VERSION=5.6

if [[ -e $HOME/pypy2-v$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf $HOME/pypy2-v$PYPY_VERSION-linux64.tar.bz2
  rm -rf $HOME/pypy2-v$PYPY_VERSION-linux64.tar.bz2
else
  wget -O - https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-$PYPY_VERSION-linux_x86_64-portable.tar.bz2 | tar -xjf -
fi

# remove, because otherwise this version will get placed into a subdir of an existing pypy/
rm -rf pypy
mv -f pypy-$PYPY_VERSION-linux_x86_64-portable /home/lightbend/pypy

## library fixup
mkdir -p /home/lightbend/pypy/lib
ln -snf /lib64/libncurses.so.5.9 /home/lightbend/pypy/lib/libtinfo.so.5

/home/lightbend/pypy/bin/pypy --version
/home/lightbend/pypy/bin/pypy -m ensurepip

