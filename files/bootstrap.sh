#/bin/bash

set -e

cd

if [[ -e /opt/pypy/bin/pypy]]; then
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
mkdir -p /opt
mv -f pypy-$PYPY_VERSION-linux_x86_64-portable /opt/pypy

## library fixup
mkdir -p /opt/pypy/lib
ln -snf /lib64/libncurses.so.5.9 /opt/pypy/lib/libtinfo.so.5

/opt/pypy/bin/pypy --version
/opt/pypy/bin/pypy -m ensurepip

