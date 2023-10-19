echo -e "#!/bin/sh\n$CC -static \$@" > /usr/bin/gcc
chmod +x /usr/bin/gcc
cd /build 
unxz < linux-4.1.39.tar.xz | tar x 
cd linux-4.1.39 
cp /build/linux.config /build/linux-4.1.39/.config 
make oldconfig ARCH=i386 
PATH=$TOOLSBIN:$CCBIN:$PATH make ARCH=i386 PATH=$CCBIN:$TOOLSBIN:$PATH 
PATH=$TOOLSBIN:$CCBIN:$PATH make INSTALL_MOD_PATH=/initramfs/ modules modules_install
cp arch/x86/boot/bzImage /CD_root/bzImage 

cd /build
gunzip < busybox-1_31_1.tar.gz | tar x
cd busybox-1_31_1 
cp ../busybox.config .config
sed -i -re '304s/-1/1/' include/libbb.h
#sed -i -re '295s/-1/1/' include/libbb.h
PATH=$TOOLSBIN:$PATH
make oldconfig 
make TGTARCH=i486 \
    LDFLAGS="--static" \
    EXTRA_CFLAGS=-m32 \
    EXTRA_LDFLAGS=-m32 \
    HOSTCFLAGS="-D_GNU_SOURCE"
make CONFIG_PREFIX=/initramfs install
rm /usr/bin/gcc
rm -rv /initramfs/share
cp -rf /build/initramfs/* /initramfs/

mkdir /initramfs/proc -p
mkdir /initramfs/tmp -p
cd /initramfs
chmod 000 /initramfs/etc/shadow
find . | cpio -o -H newc | gzip > ../CD_root/initramfs_data.cpio.gz
cd  /
cp /usr/share/syslinux/ldlinux.c32 /usr/share/syslinux/isolinux.bin CD_root/isolinux/
/opt/schily/bin/mkisofs \
    -allow-leading-dots \
    -allow-multidot \
    -l \
    -relaxed-filenames \
    -no-iso-translate \
    -o blockless.iso \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table CD_root
chmod 600 /initramfs/etc/shadow