kubectl create -f 2.deployment.yml --record
# --record: record rollout change-cause

kubectl get pods --show-labels
kubectl rollout status deployment helloworld-deployment

kubectl expose deployment helloworld-deployment --type=LoadBalancer
kubectl get svc
kubectl describe svc helloworld-deployment

kubectl set image deployment/helloworld-deployment helloworld-container=wardviaene/k8s-demo:2

kubectl rollout history deployment helloworld-deployment

kubectl rollout undo deployment helloworld-deployment
kubectl rollout undo deployment helloworld-deployment --to-revision=4
# --to-revision: specify undo to a previous state

