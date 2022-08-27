#!/bin/bash

kubectl apply \
    -f database-pod.yml \
    -f database-service.yml \
    -f helloworld-deployment.yml \
    -f helloworld-service.yml

kubectl get pods

# run a debug container to check mysql service is reachable
kubectl run -it --image=mysql --rm=true --restart=Never mysql-testing -- sh
> mysql -h mysql-service -u root -p # rootpassword

# run curl inside alpine image
kubectl run -it --image=alpine/curl --rm=true --restart=Never alpine-testing -- sh
> curl -X HEAD -i database-service:3306
> curl -X HEAD -i helloworld-service:3000

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

# hit node-js app from local computer
kubectl port-forward service/helloworld-service 8080:3000
curl localhost:8080
