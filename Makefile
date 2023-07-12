
all: mk_img


mk_img:
	docker build . -t blockless-img
	docker run  --name blockless-img blockless-img 
	docker cp blockless-img:blockless.iso .

clear:
	docker rm blockless-img
	docker rmi blockless-img
	rm blockless.iso