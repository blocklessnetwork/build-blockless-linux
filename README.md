# build-blockless-linux

## How to build

Use follow command will build the image "blockless.iso" to PWD.
```bash
make 
```

## The linux4 insert module
```
# depmod
```
use depmod to generate the `modules.alias`, `modules.dep`, `modules.symbols`
```
# modprobe ne2k_pci
```

The drivers will in the modules.alias file.

***WARNING*** when use insmod directly, the error occur, `insmod: can't insert 'ne2k-pci.ko': unknown symbol in module, or unknown parameter`, because the depended kernel is not insert into kernel.