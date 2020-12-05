# ansible-hello-world

A basic [Ansible role](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) reference example demonstrating how to use [Docker](https://docker.io) as the [Molecule](https://molecule.readthedocs.io/en/latest/) test driver, as well as in creating a development environment. It's intended as a reference example accompanying [mikeball.info/blog/testing-ansible-roles-with-docker-in-docker](http://www.mikeball.info/blog/testing-ansible-roles-with-docker-in-docker/).

This also demonstrates how to leverage Docker-in-Docker to test the role in a Concourse CI/CD task.

## Overview

For the sake of simplicity, the role's only responsibility is to create a `/hello-world.json` file on the targeted host. Its `molecule/converge.yml` file invokes the role against a Dockerized Ubuntu test container, while its `molecule/verify.yml` tests that the role behaved as expected and properly creates the `/hello-world.json` file on the targeted host. It requires no development dependencies beyond Docker.

## Test

Run `make` to start a [clapclapexcitement/dind-ansible-molecule](https://hub.docker.com/r/clapclapexcitement/dind-ansible-molecule/) container instance on which Docker is running, install Python, Ansible, and Molecule on it, and run molecule test from within the container:

```
make
```

## Bonus: Continuous Integration

### Concourse

See `ci/task.yml` for an example [Concourse task](https://concourse-ci.org/tasks.html).

The task uses the same `amidos/dcind` and `ci/tasks/test.sh` script used in development.

Its use within a Concourse pipeline `pipeline.yml` configuration file might look something like this, for example:

```yaml
resources:

- name: ansible-hello-world-pull-request
  type: pull-request
  check_every: 24h
  webhook_token: ((webhook-token))
  source:
    repository: mdb/ansible-hello-world
    access_token: ((access-token))
    v3_endpoint: https://github.com/api/v3/
    v4_endpoint: https://github.com/api/graphql

resource_types:

- name: pull-request
  type: registry-image
  source:
    repository: teliaoss/github-pr-resource

jobs:

- name: verify-pull-request
  plan:
  - get: ansible-hello-world-pull-request
    trigger: true
  - put: ansible-hello-world-pull-request
    params:
      path: ansible-hello-world-pull-request
      status: pending
  - task: test
    file: ansible-hello-world-pull-request/ci/tasks/test.yml
    privileged: true
    on_success:
      put: ansible-hello-world-pull-request
      params:
        path: ansible-hello-world-pull-request
        status: success
    on_failure:
      put: ansible-hello-world-pull-request
      params:
        path: ansible-hello-world-pull-request
        status: failure
```

### GitHub Actions

See `.github/workflows/ci.yml` for an example [GitHub Actions](https://github.com/features/actions) CI workflow.
