# kind

## installation

- <https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-a-package-manager>

## single cluster

```bash
CLUSTER_NAME="local-cluster"
kind create cluster --name "$CLUSTER_NAME"
kind get clusters
docker container ls
grep server ~/.kube/config

# inside cluster
docker exec -it "$CLUSTER_NAME-control-plane" bash
crictl ps
kubectl get pods --all-namespaces -o wide
grep server /root/.kube/config

kind delete cluster --name "$CLUSTER_NAME"
```

## multi-clusters (masters)

```bash
kind create cluster --name cluster-1
kind create cluster --name cluster-2

kubectl config get-contexts
kubectl get nodes
kubectl cluster-info --context kind-cluster-1
kubectl get nodes --context kind-cluster-1
kubectl config use-context kind-cluster-1
```

## multi-node cluster

the config file is:

``` yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
  - role: worker
networking:
  kubeProxyMode: "ipvs"
```

``` bash
kind create cluster --config ./cluster.yaml
```
