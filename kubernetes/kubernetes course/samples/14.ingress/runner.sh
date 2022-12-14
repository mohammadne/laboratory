#!/bin/bash

# check wetherar or not your cluster has an ingress controller or not, if not deploying ingress controller via bellow manifest:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

kubectl apply \
    -f apple.yml \
    -f banana.yml \
    -f orange.yml \
    -f fruits-ingress.yml

kubectl describe ingress helloworld-ingress

curl node

curl node -H 'Host: helloworld-v1.com'

curl node -H 'Host: helloworld-v2.com'
