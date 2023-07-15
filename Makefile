all: build

mk_img:
	docker build . -t blockless-img

build: mk_img
	mkdir build -p; 
	cp initramfs build/ -rf
	cp packages/linux-4.1.39.tar.xz build; 
	cp packages/busybox-1.26.2.tar.bz2 build; 
	cp busybox-1.23.1-config build/busybox.config; 
	cp config-3.17.8  build/linux.config; 
	cp build.sh  build/; 
	docker run -d -v `pwd`/build:/build --name blockless-img blockless-img bash entry.sh
	docker exec  blockless-img bash /build/build.sh
	docker cp blockless-img:blockless.iso .
	docker stop blockless-img
	docker rm blockless-img

clear:
	docker rm blockless-img
	docker rmi blockless-img
	rm blockless.iso