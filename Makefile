.PHONY: test shell

all: test

test:
	docker run \
		--volume $(PWD):/ansible-hello-world \
		--workdir / \
		--privileged \
		--rm \
		amidos/dcind \
		/ansible-hello-world/ci/tasks/test.sh

shell:
	docker run \
		--volume $(PWD):/ansible-hello-world \
		--workdir / \
		--privileged \
		--interactive \
		--tty \
		--rm \
		amidos/dcind \
			/bin/bash
