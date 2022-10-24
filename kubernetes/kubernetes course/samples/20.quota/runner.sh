#!/bin/bash

kubectl create -f resourcequota.yml -f deployments.yml

# apply limit to the pods
kubectl create -f default.yml

kubectl delete helloworld-no-quota

# apply the defaults to the helloworld-no-quota
kubectl apply -f deployments.yml
