#!/bin/bash

# we will mount configMap data to nginx `/etc/nginx/conf.d` path to be used by nginx

# create configMap (option 1)
kubectl create configmap helloworld-nginx-config --from-file=reverseproxy.conf

# create configMap (option 2)
kubectl create -f cm.yml

# the result is the same
kubectl get configmap helloworld-nginx-config -o yaml

# create a pod with 2 containers on the same pod, one is our nodejs app and
# another one is nginx reverse-proxy which will redirect traffic to port 80 of the pod
# to port 3000 of nodejs app which means we add reverse-proxy in-front of the nodejs app
kubectl create -f helloworld-nginx-pod.yml -f helloworld-nginx-service.yml

kubectl exec -it helloworld-nginx-pod -c nginx -- bash
> cat /etc/conf.d/reverseproxy.conf
# you can see it forwards the traffic to localhost:3000 (nodejs app)

kubectl port-forward service/helloworld-nginx-service 31001
curl localhost:31001
