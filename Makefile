build:
	docker build -t us.gcr.io/rox-se/ansible-demo:shane-rs-156 .

push:
	docker push us.gcr.io/rox-se/ansible-demo:shane-rs-156
