#!/bin/bash

# run 2 panes:

# in first:
kubectl get pods --watch=true

# in second:
kubectl create -f lifecycle-deployment.yml

kubectl exec -it <pod-name> -- cat /tmp/timing
kubectl exec -it <pod-name> -- tail /tmp/timing -f

kubectl delete deployment lifecycle
