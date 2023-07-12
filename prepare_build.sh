BUILD=build

if [ ! -d ${BUILD} ]; then 
    mkdir ${BUILD} 
    cp packages/linux-4.1.39.tar.xz ${BUILD} 
    ( 
        cd ${BUILD} 
        tar -xvf linux-4.1.39.tar.xz 
        cd linux-4.1.39 
        cp ../../config-3.17.8 .config 
    ) 
    cp packages/busybox-1.26.2.tar.bz2 ${BUILD} 
    (
        cd ${BUILD}
        tar -xjvf busybox-1.26.2.tar.bz2
        cd busybox-1.26.2
        cp ../../busybox-1.23.1-config .config
    )
fi;