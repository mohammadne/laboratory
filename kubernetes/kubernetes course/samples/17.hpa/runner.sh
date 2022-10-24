#!/bin/bash

kubectl get hpa

# pane 1

kubectl run -it load-generator --image=busybox /bin/sh
> while true; do wget http://hpa-example.default.svc.cluster.local:31001; done

# pane 2

watch kubectl get pods

# pane 3

watch kubectl get hpa