echo -e "#!/bin/sh\n$CC -static \$@" > /usr/bin/gcc
cd linux-4.1.39 
make oldconfig ARCH=i386 
make ARCH=i386 PATH=$CCBIN:$TOOLSBIN:$PATH 
ln arch/x86/boot/bzImage /CD_root/bzImage 

cd ..
cd busybox-1.26.2 
sed -i -re '295s/-1/1/' include/libbb.h
PATH=$TOOLSBIN:$PATH
make oldconfig 
make TGTARCH=i486 \
    LDFLAGS="--static" \
    EXTRA_CFLAGS=-m32 \
    EXTRA_LDFLAGS=-m32 \
    HOSTCFLAGS="-D_GNU_SOURCE"
make CONFIG_PREFIX=/initramfs install
rm /usr/bin/gcc