#! /bin/bash

# build CNI plugins
cd /tmp && git clone https://github.com/containernetworking/plugins.git && /tmp/plugins/build_linux.sh

# setup the cluster
kind create cluster --name sandbox --config ./cluster.yaml

# load flannel images and install flannel CNI
kind load docker-image docker.io/flannel/flannel-cni-plugin:v1.4.1-flannel1 --name sandbox
kind load docker-image docker.io/flannel/flannel:v0.25.1 --name sandbox
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

ip address list
bridge link show

# deploy hello-world
kind load docker-image nicolaka/netshoot:v0.12 --name sandbox
kubectl apply -f ./hello-world.yaml

docker exec -it sandbox-worker bash
apt update && apt install tshark -y
apt install tshark -y
tshark -V --color -i eth0 -d udp.port=8472,vxlan -f "port 8472"
