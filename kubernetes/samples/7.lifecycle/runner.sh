#!/bin/bash

# note: in okd environment because you don't have permission on busybox container
# this process will be failed, run it on other clouds like okteto.

# run 2 panes:

# in first:
watch -n1 kubectl get pods

# in second:
kubectl create -f lifecycle-deployment.yml

kubectl exec -it <pod-name> -- cat /timing
kubectl exec -it <pod-name> -- tail /timing -f
