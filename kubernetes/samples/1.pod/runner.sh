# create resource 
kubectl create -f helloworld-pod.yml

# get a SHELL into the pod
kubectl exec --stdin --tty helloworld-pod -- /bin/bash
kubectl exec helloworld-pod -- touch text.txt

# expose the pod
kubectl expose pod helloworld-pod --type=NodePort --name=helloworld-svc
kubectl get service
kubectl describe service helloworld-svc

# run a debug pod
kubectl run busybox -it --image=busybox --restart=Never --rm=true
> telnet <ENDPOINT> <PORT> (from describe of service)
> GET /

kubectl delete pod busybox
