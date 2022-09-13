#!/bin/bash

kubectl create -f helloworld-rc.yml

kubectl get pods
kubectl get rc

kubectl scale rc helloworld-rc --replicas=4
kubectl delete pod <one-of-the-pods>
kubectl get pods

kubectl delete rc helloworld-rc 
