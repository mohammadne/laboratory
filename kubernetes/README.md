# Kubernetes

## tutorials

- [Cloud Native Certified Kubernetes Administrator](https://lucid.app/lucidchart/b1b62a6e-1266-41dd-b48d-3c44252fb88f/view)

- [qdnqn](https://qdnqn.com/)

- [tonylixu's medium](https://tonylixu.medium.com/)

- [calico series](https://projectcalico.docs.tigera.io/about/about-calico)

- [k8s iptable chains](https://examples.openshift.pub/networking/k8s-iptables-chains/)

- [Kubernetes Deep Dive](https://acloudguru.com/course/kubernetes-deep-dive)

## Books

- [Core Kubernetes](https://www.manning.com/books/core-kubernetes)
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

- [kubelet](https://aws.plainenglish.io/kubernetes-deep-dive-kubelet-e4527ed56f4c)
- [authN and authZ](https://faun.pub/how-to-add-an-user-to-a-kubernetes-cluster-an-overview-of-authn-in-k8s-d198adc08119)
- [kuberntes operators](https://developer.ibm.com/learningpaths/kubernetes-operators/operators-extend-kubernetes/)
- [mutating and validating admission webhook](https://slack.engineering/simple-kubernetes-webhook/)
- etcd watch
- [api server watch](https://sysdig.com/blog/monitor-kubernetes-api-server/)
- controller pattern and workflow
- scheduling pipeline

### runtime

- [cri](https://www.aquasec.com/cloud-native-academy/container-security/container-runtime-interface/)
- cri grpc call
- [oci](https://phoenixnap.com/kb/docker-vs-containerd-vs-cri-o)
- [crio](https://cri-o.io/)
- [containerd](https://earthly.dev/blog/containerd-vs-docker/)
- [LXC](https://earthly.dev/blog/lxc-vs-docker/)
- [runc](https://stackoverflow.com/questions/41645665/how-containerd-compares-to-runc)
- lib/image
- lib/container
- [kubelet watch](https://aws.plainenglish.io/kubernetes-deep-dive-kubelet-e4527ed56f4c)
- [conmon](https://github.com/containers/conmon)
- [infra (pause) container](https://blog.devgenius.io/k8s-pause-container-f7abd1e9b488)
- pod sandbox
- [cgroup](https://www.nginx.com/blog/what-are-namespaces-cgroups-how-do-they-work/)
- namespaces
- [chroot](https://www.howtogeek.com/441534/how-to-use-the-chroot-command-on-linux/)
- [pivot-root](https://superuser.com/questions/1575316/usage-of-chroot-after-pivot-root)
- [hypervisor](https://www.virtasant.com/blog/hypervisors-a-comprehensive-guide)
- [sidecar container](https://www.containiq.com/post/kubernetes-sidecar-container)

### networking

- kube-proxy
- service (clusterip, loadbalancer, node port)
- iptables chains
- cni (routing)
- [overlay network (vxlan) flannel](https://community.arm.com/arm-community-blogs/b/tools-software-ides-blog/posts/understanding-and-deploying-overlay-networks)
- [bgp based (cilium, calico)](https://www.ibm.com/docs/en/cloud-private/3.2.0?topic=ins-calico)
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

- ceph, openstack (Nova, Cinder, Glance, keystone, Ironic,...), Openshift-OKD
- linux: lpic1
- Ansible, Terraform
- network+, cnna routing & switching
- keepalived, Metallb
- HAProxy, Nginx
- Helm
- Prometheus, ELK, Fluentd
- KVM-QEMU
- FCOS, Ignition
- [Istio](https://tetrate.io/what-is-istio-service-mesh/)
- packer
