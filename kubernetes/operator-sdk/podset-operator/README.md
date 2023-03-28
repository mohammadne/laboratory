# podset operator

podset operator is a golang operator to demystify the kubernetes operators and to get an overview of the operators developed by `operator framework`.

## Description

podset operator behaves very like the replica-set, created for learning purposes.

## Getting Started

You’ll need a Kubernetes cluster to run against. You can use [KIND](https://sigs.k8s.io/kind) to get a local cluster for testing, or run against a remote cluster.
**Note:** Your controller will automatically use the current context in your kubeconfig file (i.e. whatever cluster `kubectl cluster-info` shows).

## Running

``` bash
# scaffold project
operator-sdk init --project-name podset-operator --domain=example.com --repo=github.com/mohammadne/sandbox/podset-operator

# https://book.kubebuilder.io/migration/multi-group.html
kubebuilder edit --multigroup=true

# create api
operator-sdk create api --group=app --version=v1alpha1 --kind=PodSet --controller --resource

# make changes to the api
vim api/v1alpha1/podset_type.go

# update the api/v1alpha1/zz_generated.deepcopy.go
make generate

# generate the CRD manifests at config/crd/bases/app.example.com_podsets.yaml
make manifest

# make changes to the controller
vim controllers/podset_controller.go

# run operator locally outside the cluster
make install run # first terminal
kubectl create -f config/samples/app_v1alpha1_podset.yaml # second terminal
kubectl get podset
kubectl get podset podset-sample -o yaml
kubectl get pods podset-sample-podqzwql -o yaml | grep ownerReferences -A5
kubectl patch podset podset-sample --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value": 5}]'
kubectl get pods
kubectl delete podsets.app.example.com podset-sample
make uninstall

# push operator image to registry
vim Makefile # update IMAGE_TAG_BASE
make docker-build docker-push

# run operator inside the cluster
make deploy
kubectl apply -f config/samples/app_v1alpha1_podset.yaml
make undeploy

```

### How it works

This project aims to follow the Kubernetes [Operator pattern](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)

It uses [Controllers](https://kubernetes.io/docs/concepts/architecture/controller/)
which provides a reconcile function responsible for synchronizing resources untile the desired state is reached on the cluster.

### Test It Out

1. Install the CRDs into the cluster:

    ```sh
    make install
    ```

2. Run your controller (this will run in the foreground, so switch to a new terminal if you want to leave it running):

    ```sh
    make run
    ```

**NOTE:** You can also run this in one step by running: `make install run`

### Modifying the API definitions

If you are editing the API definitions, generate the manifests such as CRs or CRDs using:

```sh
make manifests
```

**NOTE:** Run `make --help` for more information on all potential `make` targets

More information can be found via the [Kubebuilder Documentation](https://book.kubebuilder.io/introduction.html)

## License

Copyright 2022.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
