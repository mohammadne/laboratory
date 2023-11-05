# operator SDK

## tutorials

- <https://sdk.operatorframework.io/docs/building-operators/golang/tutorial/>

### Creation

```bash
# scaffold base project
operator-sdk init --domain=mohammadne.me --project-name=caas-operator --repo=github.com/mohammadne/caas-operator

# https://book.kubebuilder.io/migration/multi-group.html
operator-sdk edit --multigroup=true

# resource -> generates the api directory
# controller -> generates the controller directory
operator-sdk create api --group=apps --version=v1alpha1 --kind=Executer --controller --resource

operator-sdk create webhook --group apps --version v1alpha1 --kind Executer --programmatic-validation
```

### Development

```bash
# make changes to the api
vim api/v1alpha1/memcahed_type.go

# generate code containing DeepCopy, DeepCopyInto, and DeepCopyObject method implementations.
# here it updates the api/v1alpha1/zz_generated.deepcopy.go
make generate

# make changes to the controller logic
vim controllers/memcahed_controller.go

# generate WebhookConfiguration, ClusterRole and CustomResourceDefinition objects.
# here it generates the CRD manifests at config/crd/bases/cache.mohammadne.me_memcaheds.yaml and config/rbac/role.yaml
make manifests
```

### Build

```bash
# build the controller binary (golang)
make build

# run the controller from your host (locally)
make run

# push operator image to registry
vim Makefile # update IMAGE_TAG_BASE
make docker-build docker-push
```

### Deployment

```bash
# install CRDs into the K8s cluster specified in ~/.kube/config
make install

# deploy controller to the K8s cluster specified in ~/.kube/config
make deploy
```

### Test

1. install CRDs

    ```bash
    # install CRDs into cluster and run the operator locally (outside the cluster)
    make install run
    ```

2. run the controller

    - locally

        ```bash
        make run
        ```

    - in cluster

        ```bash
        # push operator image to registry
        vim Makefile # update IMAGE_TAG_BASE
        make docker-build docker-push

        make deploy
        ```

3. deploy CR and test it

    ```bash
    # deploy the CR into the cluster
    kubectl apply -f config/samples/cache_v1alpha1_memcached.yaml

    kubectl get memcached
    kubectl get memcached memcached-sample -o yaml
    kubectl get pods memcached-sample-podqzwql -o yaml | grep ownerReferences -A5
    kubectl patch memcached memcached-sample --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value": 5}]'
    kubectl get pods
    kubectl delete memcacheds.cache.mohammadne.me memcached-sample
    ```

4. undeploy controller from the cluster (if you run controller in the cluster)

    ```bash
    make undeploy
    ```

5. uninstall CRDs from the cluster

    ```bash
    make uninstall
    ```
