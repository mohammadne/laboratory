#!/bin/bash

kubectl create -f 5.probes.yml && watch -n1 kubectl get pods
