## expose a port on local-host-machine
- docker container run -p

## Basic networking
- private IP address (great): https://www.avast.com/c-ip-address-public-vs-private
- TCP (great): https://www.lifesize.com/en/blog/tcp-vs-udp/
- DNS: https://kinsta.com/knowledgebase/what-is-dns/
- nameserver: https://kinsta.com/knowledgebase/what-is-a-nameserver/
- IP: https://www.guru99.com/tcp-vs-udp-understanding-the-difference.html
- VPN: https://virgool.io/@hosseinkhani/%D8%B4%D8%A8%DA%A9%D9%87-%D8%AE%D8%B5%D9%88%D8%B5%DB%8C-%D9%85%D8%AC%D8%A7%D8%B2%DB%8C-vpn-%DA%86%DB%8C%D8%B3%D8%AA-rku2wjqqjbw2
- virtual network: https://www.parallels.com/blogs/ras/what-is-a-virtual-network/
- bridge network: https://docs.docker.com/network/bridge/
- subnets: https://www.cloudflare.com/en-gb/learning/network-layer/what-is-a-subnet/
- firewalls: https://www.checkpoint.com/cyber-hub/network-security/what-is-firewall/
- NAT firewall: https://www.forcepoint.com/cyber-edu/firewall

## Linux commands
1. private ip
- ip address | grep enp2s0
- hostname -I

2. public ip
- curl icanhazip.com
- wget -qO - icanhazip.com
- curl ipinfo.io/ip


## some notes

- batteries included, but removable: defaults work well in many cases 
but easy to swap out parts to customize it

- when you start a container, in background you will connecting to a 
particular docker network (default: bridge network)

- each virtual network (like bridge network) routes through NAT firewall on host IP

- all containers on a virtual network can talk to each other without -p

- docker container run -p 1234:80 --name alpine -it -d alpine

- docker container port alpine

## container ip

- docker container run -d -p 80:80 --name webhost nginx

- docker container inspect --format='{{ .NetworkSettings.IPAddress }}' webhost

### note

1. docker virtual networks will be NAT'ed behind host-IP

2. `host` virtual network sacrifices(don't have) security of container model (vs bridge)

3. `none` virtual network only leaves localhost interface in container

## network driver
3rd party extensions that give you virtual network features
the default is `bridge`

## host ip and container ip
interfaces host IP: ip addr (3: wlp1s0 -> line 3)
machine host IP: curl ident.me

## Docker networks CLI managment

1. show networks: 
docker network ls

2. inspect a network: 
docker network inspect

3. create a network: 
docker network create --driver

4. attach a network to container: 
docker network connect

5. detach a network from container: 
docker network disconnect



## Display detailed information on one or more networks
- docker network inspect bridge

it has a part called Containers which will list all attached containers

## spawn a new virtual network for you to attach containers to
- docker network create my_app_net

it will create you network with the driver of bridge.

## CREATE A NEW CONTAINER IN NEW VIRTUAL NETWORK
- docker container run --network my_app_net --name new_alpine -it -d alpine
- docker container run --network my_app_net --name my_alpine -it -d alpine

## CHECK IT'S NETWORK
- docker network inspect my_app_net

## CONNECT ORIGINAL BRIDGE NETWORK TO my_app_net
- docker network connect <network_name-or-id> <container_name-or-id>

### note
1. the connect will dynamically creates a NIC in a container 
on an existing virtual network
2. a container can connect to multiple networks, on each
network, it has a different IP address

## Display detailed information on one or more containers
- docker container inspect <container-id>

you can see that container is attached to 2 network

## DISCONNECT ORIGINAL BRIDGE NETWORK TO my_app_net
- docker network disconnect <my_app_net-id> <container_name-id>

## DNS
- host-name: https://www.ibm.com/docs/en/cics-ts/5.3?topic=concepts-host-names
- docker daemon (engine) has a built-in DNS server that containers use by default
- docker defaults the hostname to the container's name but you can set aliases for it
- docker uses container names as host-name (dns-server and find ip address) equivalent 
for containers to talk to each-other
- we use `--link` to enable DNS on default bridge network
- do your best to avoid `static-IP` for talking to containers.
- default `bridge` network hasn't built-in DNS-server and if you want to use default
you should manualy add links between containers

## ping by dns
- docker network create test
- docker container run -d -p 80:80 --name webhost --network test nginx
- docker container run -d -it --name my_alpine --network test alpine
- docker container exec -it my_alpine ping webhost
- docker container exec -it webhost ping 172.17.0.2

=> containers shouldn't rely on IP's for inter-communication, because the
order of creation and... can change the IP assignment address

if 2 containers are not on the same virtual network, then we will get
a bad-address error:
- docker container exec -it my_alpine ping alpine

## automatic removal of container
- option `--rm` will detach container after exiting
--rm => causes Docker to automatically remove the container when it exits

nslookup is a network administration command-line tool for 
querying the Domain-Name System to obtain domain-name or IP-address mapping, 
or other DNS records.
