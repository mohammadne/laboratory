#!/bin/bash

kubectl create -f helloworld-deployment.yml --record
# --record: record rollout change-cause when using rollout history to show them

kubectl get rs
kubectl get pods --show-labels
kubectl rollout status deployment helloworld-deployment

kubectl expose deployment helloworld-deployment --type=LoadBalancer
kubectl get svc
kubectl describe svc helloworld-deployment

# to hit the ClusterIP directly via busybox 
kubectl run busybox -it --image=busybox --restart=Never --rm=true
> telnet <ENDPOINT> <PORT> (from describe of service)
> GET /

# update deployment image
kubectl set image deployment helloworld-deployment helloworld-container=wardviaene/k8s-demo:2

# each history has a revision number that we can rollout to that one.
kubectl rollout history deployment helloworld-deployment

# make edit to the deployment
kubectl edit deployment helloworld-deployment

kubectl rollout undo deployment helloworld-deployment

# --to-revision: specify revision number
kubectl rollout undo deployment helloworld-deployment --to-revision=4
