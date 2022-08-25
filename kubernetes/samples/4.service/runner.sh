# kubectl
kubectl expose deployment wordpress-deployment --port=31001 --type=NodePort

# yaml manifest
kubectl create -f helloworld-deployment.yml -f helloworld-service.yml

kubectl get svc
kubectl describe service helloworld-service

kubectl run busybox -it --image=busybox --restart=Never --rm=true
> telnet <IP> <PORT> (from describe of service)
> GET /

kubectl get pods --output=wide
# an output with pods IP addresses

kubectl port-forward service/helloworld-service 31001
