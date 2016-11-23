#/bin/bash

set -e

cd

if [[ -e $HOME/.bootstrapped ]]; then
  exit 0
fi

PYPY_VERSION=5.6.0

if [[ -e $HOME/pypy2-v$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf $HOME/pypy2-v$PYPY_VERSION-linux64.tar.bz2
  rm -rf $HOME/pypy2-v$PYPY_VERSION-linux64.tar.bz2
else
  wget -O - https://bitbucket.org/pypy/pypy/downloads/pypy2-v$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
fi

# remove, because otherwise this version will get placed into a subdir of an existing pypy/
rm -rf pypy
mv -f pypy2-v$PYPY_VERSION-linux64 pypy

## library fixup
mkdir -p pypy/lib
ln -snf /lib64/libncurses.so.5.9 $HOME/pypy/lib/libtinfo.so.5

mkdir -p $HOME/bin

cat > $HOME/bin/python <<EOF
#!/bin/bash
PYTHONPATH=/home/core/pypy/lib-python/2.7/:$PYTHONPATH LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH exec $HOME/pypy/bin/pypy "\$@"
EOF

chmod +x $HOME/bin/python
$HOME/bin/python --version
$HOME/bin/python -m ensurepip

touch $HOME/.bootstrapped
