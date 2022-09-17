#!/bin/bash

############################################################################## node affinity

# spin up a 2-node cluster and label one of them with
kubectl get node
kubectl label node <node-name> env=dev

kubectl create -f node-affinity.yml

# label the second worker with env and engineering-project1
kubectl label node <node-2-name> env=dev team=engineering-project1

kubectl delete pod <pod-name>

# now the new pod will be scheduled on the second worker node

############################################################################## pod affinity

kubectl craete pod-affinity.yml

kubectl scale deployment pod-affinity-2

kubetl delete -f pod-affinity.yml

kubectl describe nodes | less

vim pod-affinity.yml # change hostname to zone

############################################################################## pod anti-affinity

kubectl craete pod-anti-affinity.yml

# intersting
kubectl get pods -o wide
