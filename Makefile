.PHONY: test shell

all: test

test:
	docker run \
		--volume $(PWD):/ansible-hello-world \
		--workdir /ansible-hello-world \
		--privileged \
		--rm \
		clapclapexcitement/dind-ansible-molecule \
		/ansible-hello-world/ci/tasks/test.sh

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
