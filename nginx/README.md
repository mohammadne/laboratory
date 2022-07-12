# Nginx

## reverse-proxy

> in this scenario we have a reverse proxy in fron of a backend service and proxy the request to our backend and respond to the client via his/her request uri

``` bash
# run the compose
docker compose up -d

# curl to the reverse-proxy container
curl localhost:8080/i-love-devops
```

## reverse-proxy-prefix

> in this scenario we have a reverse proxy in fron of a backend service and proxy the request to our backend and respond to the client via his/her request uri but here we intercept the uri

``` bash
# run the compose
docker compose up -d

# curl to the reverse-proxy container
curl localhost:8080/v2/devops
# leads to -> version: 1, uri: devops

curl localhost:8080/custon-name/devops
# leads to -> no version, uri: /custon-name/devops
```