#!/bin/bash

##################################################################### by helm repository

helm install wordpress bitnami/wordpress \
    --set persistence.size=1Gi \
    --set mariadb.primary.persistence.size=1Gi

helm delete wordpress bitnami/wordpress

  echo Username: user
  echo Password: $(kubectl get secret --namespace mohammadne wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)

##################################################################### from manifest

kubectl apply -f 7.wordpress_secret.yml

# run a debug ubuntu
kubectl run -i --tty ubuntu --image=mysql --restart=Never -- sh
> mysql -h mysql -u root -p
kubectl delete pod ubuntu

kubectl port-forward service/wordpress 31001
# in browser
127.0.0.1:31001

# mysql -h database-service -P 3306 --protocol=tcp -u root -p