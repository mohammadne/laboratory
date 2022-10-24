#!/bin/bash

# -----------------------------------------------------> generation

# generate secrets via kubectl (here filenames would be the key and their contents would be the values)
echo -n "root" > ./usename.txt
echo -n "password" > ./password.txt
kubectl create secret generic helloworld-secrets --from-file=./username.txt --from-file=./password.txt

# generate secrets via yaml definition
kubectl create -f helloworld-secrets.yml

# -----------------------------------------------------> usage

# use secrets as volume
kubectl create -f helloworld-pod-volume.yml

# use secrets as environment variables
kubectl create -f helloworld-pod-env.yml

kubectl get pods

kubectl exec helloworld-pod -it -- /bin/bash
> cat /etc/creds/username
> cat /etc/creds/password
