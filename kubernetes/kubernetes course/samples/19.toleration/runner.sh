#!/bin/bash

kubectl get node | grep master

# checkout master taints
kubectl get  node <master-node-name> -o yaml | less

# taint of of the nodes
kubectl taint nodes <NODE-NAME> type=specialnode:NoSchedule

kubectl create -f deployments.yml

# taint a node with NoExecute
kubectl taint nodes NODE-NAME testkey=testvalue:NoExecute

# untaint a node
kubectl taint nodes NODE-NAME testkey-
