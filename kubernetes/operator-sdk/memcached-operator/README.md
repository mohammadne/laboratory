# Memcached Operator

``` bash
operator-sdk init --project-name memcached-operator --domain=example.com --plugins=ansible
operator-sdk create api --group=cache --version=v1alpha1 --kind=Memcached --generate-role --generate-playbook

```
