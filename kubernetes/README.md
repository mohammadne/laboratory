# Kubernetes

## tutorials

- [k8s networking](https://kube.academy/courses/networking-in-kubernetes)

- [k8s architecture](https://kube.academy/courses/kubernetes-in-depth/)

- [Kubernetes Deep Dive](https://acloudguru.com/course/kubernetes-deep-dive)

- [Cloud Native Certified Kubernetes Administrator](https://lucid.app/lucidchart/b1b62a6e-1266-41dd-b48d-3c44252fb88f/view)

- [authN and authZ](https://faun.pub/how-to-add-an-user-to-a-kubernetes-cluster-an-overview-of-authn-in-k8s-d198adc08119)

## Books

- Kubernetes in Action
- Kubernetes: Up and Running, 3rd Edition
- Kubernetes Patterns: Reusable Elements for Designing Cloud-Native Applications
- Kubernetes Best Practices
- Programming Kubernetes: Developing Cloud-Native Applications
- Kubernetes Security and Observability
- Hacking Kubernetes
- Kubernetes Operators
- OpenShift in Production
- Kubernetes Networking
- GitOps and Kubernetes
- Production Kubernetes
- Learning Helm: Managing Apps on Kubernetes
- Cloud Native DevOps with Kubernetes, 2nd Edition

## Tools

- [kubernetes](https://kubernetes.io/docs/home/)
- [openshift](https://docs.openshift.com/container-platform/4.8/welcome/index.html)
- [kustomize](https://kustomize.io/)
- [helm](https://helm.sh/docs/)
- [coredns](https://coredns.io/)
- [etcd](https://etcd.io/)
- [rook](https://rook.io/)
- [kubebuilder](https://book.kubebuilder.io/)
- [cloud.redhat](https://cloud.redhat.com/learn/topics/operators)
- [containernetworking](https://github.com/containernetworking/cni)
- [kubernetes-csi](https://kubernetes-csi.github.io/docs/)
- [smi-spec](https://smi-spec.io/)
- [cri-o](https://cri-o.io/)
- [k8snetworkplumbingwg](https://github.com/k8snetworkplumbingwg/multus-cni)
- [container-object-storage-interface](https://container-object-storage-interface.github.io/)
- [gateway-api](https://gateway-api.sigs.k8s.io/)
- [ebpf](https://ebpf.io/)

## Confrences

- cncfcon
- kubeconf

## materials

### control plane

- kubelet
- authN
- authZ
- mutation webhook
- admission webhook
- admission workflow
- etcd watch
- api server watch
- controller pattern and workflow
- scheduling pipeline

### runtime

- cri
- kubelet watch
- cri grpc call
- crio
- oci
- runc
- lib/image
- lib/container
- conmon
- infra (pause) container
- pod sandbox
- cgroup
- namespaces
- chroot
- pivot-root

### networking

- kube-proxy
- service (clusterip, loadbalancer, node port)
- iptables chains
- cni (routing)
- overlay network (vxlan) flannel
- bgp based (cilium, calico)
- ingress controller
- dns, kubelet dns, dnsPolicy, coredns
- life of a packet (North south, East West)

### storage

- pv
- pvc
- csi
- csi provisioner
- csi driver
- csi attacher/resizer/snapshotter
- a/d controller
- Life of a PVC
- kubelet fsGroup policy
- kubelet selinux relabling

### others

- ceph, openstack

- linux: lpic1

- network+, cnna routing & switching
