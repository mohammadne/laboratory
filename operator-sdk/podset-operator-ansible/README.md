# podset operator ansible

``` bash
operator-sdk init --project-name podset-operator --domain=example.com --plugins=ansible
operator-sdk create api --group=app --version=v1alpha1 --kind=PodSet --generate-role
```
