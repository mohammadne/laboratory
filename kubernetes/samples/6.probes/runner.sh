#!/bin/bash

kubectl create -f helloworld-pod.yml && watch -n1 kubectl get pods
