# ansible-hello-world

A basic [Ansible role](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) reference example demonstrating how to use [Docker](https://docker.io) as the [Molecule](https://molecule.readthedocs.io/en/latest/) test driver, as well as in creating a development environment.

This also demonstrates how to leverage Docker-in-Docker to test the role in a Concourse CI/CD task.

## Test

```
make
```

## Bonus

See `ci/task.yml` for an example [Concourse task](https://concourse-ci.org/tasks.html).
