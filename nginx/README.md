# Nginx

## reverse-proxy

- in this scenario we have a reverse proxy in fron of a backend service and proxy the request to our backend and respond to the client via his/her request uri

``` bash
# run the compose
docker compose up -d

# curl to the reverse-proxy container
curl localhost:8080/i-love-devops
```

## reverse-proxy-prefix

- in this scenario we have a reverse proxy in fron of a backend service and proxy the request to our backend and respond to the client via his/her request uri but here we intercept the uri

``` bash
# run the compose
docker compose up -d

curl localhost:8080/v2/devops
# leads to -> version: 1, uri: devops

curl localhost:8080/custon-name/devops
# leads to -> no version, uri: /custon-name/devops
```

## load-balancing

- in this scenario we have a reverse proxy in fron of a 2 backend services and proxy the request to our backends based on the defined upstream

- here we used `static ip` in compose file to use them in loadbalancing 

``` bash
# run the compose
docker compose up -d

# hit the load balancer
curl localhost:8000
```

- here we want to use Apache HTTP server benchmarking tool named `ab` to test how many times we hit backend-1 and how many times backend-2 has been hitted with corresponding ip addresses of 8001 and 8002

``` bash
ab -n 100 -v 4 http://127.0.0.1:8000/ | grep 'requesting to server with port:' | sort | uniq -c
#  75 requesting to server with port: 8001
#  25 requesting to server with port: 8002
```
