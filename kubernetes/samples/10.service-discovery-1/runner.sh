#!/bin/bash

kubectl run -it --image=nicolaka/netshoot --rm=true netshoot -- bash

# get actual IP of the pod
hostname -I
# 10.136.112.93

# display the system's DNS name
hostname 
# netshoot

# show dns-server or nameserver (option 1)
cat /etc/resolv.conf 
# search mohammadne-playground.svc.cluster.local svc.cluster.local cluster.local c.okteto-prod.internal
# nameserver 172.30.0.10
# options ndots:5

# show dns-server or nameserver (option 2)
nslookup google.com
# Server:		172.30.0.10
# Address:	172.30.0.10:53

ping 172.30.0.10 -Pn

# show dns-server or nameserver (option 3)
kubectl get service -n kube-system kube-dns
# NAME       TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)         AGE
# kube-dns   ClusterIP   10.152.0.10   <none>        53/UDP,53/TCP   15d
