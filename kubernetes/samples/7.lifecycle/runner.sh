#!/bin/bash

# run 2 panes:

# in first:
watch -n1 kubectl get pods

# in second:
kubectl create -f lifecycle-deployment.yml

kubectl exec -it <pod-name> -- cat /tmp/timing
kubectl exec -it <pod-name> -- tail /tmp/timing -f
