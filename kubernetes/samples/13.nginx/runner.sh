#!/bib/bash

# create configMap (option 1)
kubectl create configmap helloworld-nginx-config --from-file=reverseproxy.conf

# create configMap (option 2)
kubectl create -f cm.yml

# the result is the same
kubectl get configmap helloworld-nginx-config -o yaml

# create pod & service
kubectl create -f helloworld-nginx-pod.yml -f helloworld-nginx-service.yml



kubectl exec -it helloworld-nginx-pod -c nginx -- bash
> cat /etc/conf.d/reverseproxy.conf
# you can see it forwards the traffic to localhost:3000 (nodejs app)

kubectl port-forward service/helloworld-nginx-service 31001
curl localhost:31001
