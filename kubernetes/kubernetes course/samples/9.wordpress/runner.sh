#!/bin/bash

kubectl apply \
  -f secrets-secret.yml \
  -f mysql-deployment.yml \
  -f mysql-service.yml \
  -f wordpress-deployment.yml \
  -f wordpress-service.yml

# run a debug mysql container
kubectl run --stdin --tty --image=mysql --restart=Never --rm=true mysql-pod -- sh
> mysql -h mysql -u root -p
# type 'password' for the password

kubectl port-forward service/wordpress 31001
# in browser
127.0.0.1:31001

# mysql -h database-service -P 3306 --protocol=tcp -u root -p