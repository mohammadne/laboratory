#!/bin/bash

kubectl apply \
    -f database-pod.yml \
    -f database-service.yml \
    -f helloworld-deployment.yml \
    -f helloworld-service.yml

kubectl get pods

# run tshoot image
kubectl run -it --image=nicolaka/netshoot --rm=true --restart=Never tshoot -- bash
> nslookup database-service
> dig database-service # https://stackoverflow.com/questions/50668124
> dig database-service.mohammadne-playground.svc.cluster.local
> curl helloworld-service
> cat /etc/resolv.conf

# run a debug container to check mysql service is reachable
kubectl run -it --image=mysql --rm=true --restart=Never mysql-testing -- sh
> mysql -h database-service -u root -p # rootpassword

# get into mysql database (check records)
kubectl exec database -it -- mysql -u root -p
> SHOW DATABASES;
> USE helloworld;
> SHOW tables;
> SELECT * FROM visits;
> \q

# get into helloworld-deployment container
kubectl exec helloworld-deployment-pod-id -it -- sh
> curl localhost:3000

# run a debug busybox
kubectl run -it --image=busybox --rm=true --restart=Never busybox-testing -- sh
> nslookup helloworld-service
# shows the dns-server + ClusterIp of the helloworld-service

# get pod logs
kubectl logs helloworld-deployment-id 
# connection to db established

# hit node-js app from local computer (local:pod)
kubectl port-forward service/helloworld-service 8080:3000
curl localhost:8080
