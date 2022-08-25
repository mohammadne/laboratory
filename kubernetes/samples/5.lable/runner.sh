kubectl get nodes --show-labels

kubectl create -f helloworld-pod.yml
kubectl get pods --show-lables # pods are in Pending status (failed to fit any node)
kubectl get pods -l lable-key=lable-value # filter out the result
kubectl describe pod pending-pod-name

# label minikube node
kubectl label nodes minikube hardware=high-spec

kubectl get pods # pods are in Pending status (failed to fit any node)
