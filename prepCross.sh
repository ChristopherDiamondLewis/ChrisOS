#!/bin/bash

#
#   @note Please refer to https://wiki.osdev.org/GCC_Cross_Compiler
#           for details on what is going on here.
#
#

mkdir cross 
cd cross


#SET UP ENV VARIABLES

export PREFIX="$(pwd)"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

#FOR BUILD UTILITIES INSTALL

wget https://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.gz
tar -xvf binutils-2.30.tar.gz
mkdir build-binutils
cd build-binutils

../binutils-2.30/configure --target=$TARGET --prefix="$PREFIX" --disable-nls  --with-sysroot --disable-werror

make && make install

cd ..

#For GCC INSTALL

wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.3.tar.gz

wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz

wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz

tar  -xvf gmp-5.1.3.tar.gz
tar -xvf mpfr-4.1.0.tar.gz
tar -xvf mpc-1.2.1.tar.gz

mv gmp-5.1.3 gcc-7.5.0/gmp
mv mpfr-4.1.0 gcc-7.5.0/mpfr
mv mpc-1.2.1 gcc-7.5.0/mpc


../gcc-7.5.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers

make all-gcc && make all-target-libgcc && make install-gcc && make install-target-libgcc


exit 0