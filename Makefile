
all: mk_img


mk_img:
	docker build . -t blockless-img
	docker run blockless-img  --name blockless-img
	docker cp blockless-img:blockless.iso .

clear:
	docker rm blockless_img
	docker rmi blockless-img