# create resource 
kubectl create -f helloworld.yml

# get a SHELL into the pod
kubectl exec --stdin --tty helloworld-pod -- /bin/bash
kubectl exec helloworld-pod -- touch text.txt

# expose the pod
kubectl expose pod helloworld-pod --type=NodePort --name=helloworld-svc
kubectl get service
kubectl describe service helloworld-svc

# run a debug pod
kubectl run -i --tty busybox --image=busybox --restart=Never -- sh
> telnet <ENDPOINT> <PORT> (from describe of service)
> GET /
kubectl delete pod busybox
