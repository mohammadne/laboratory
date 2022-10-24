#!/bin/bash

# generate configMap using files
kubectl create configmap app-config --from-file=properties.conf

kubectl port-forward pod/helloworld-pod 3000:3000
curl localhost:3000
