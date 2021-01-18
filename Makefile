build:
	CGO_ENABLED=0 GOOS=linux go build -o website-controller -a pkg/website-controller.go

image: build
	docker build -t houlai/website-controller .

push: image
	docker push houlai/website-controller:latest
