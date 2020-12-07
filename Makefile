.PHONY: test shell

all: test

test:
	docker run \
		--volume $(PWD):/ansible-hello-world \
		--workdir /ansible-hello-world \
		--privileged \
		--rm \
		--tty \
		clapclapexcitement/dind-ansible-molecule \
		molecule test

shell:
	docker run \
		--volume $(PWD):/ansible-hello-world \
		--workdir /ansible-hello-world \
		--privileged \
		--interactive \
		--tty \
		--rm \
		clapclapexcitement/dind-ansible-molecule \
			/bin/bash
