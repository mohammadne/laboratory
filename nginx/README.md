# Nginx

``` bash
# run the compose with atest bind mounts
docker compose stop && docker compose rm -f && docker compose up -d
```

## tutorials

- <https://www.whizlabs.com/blog/nginx-tutorial-for-beginners/>

## reverse-proxy

- in this scenario we have a reverse proxy in front of a backend service and proxy the request to our backend and respond to the client via his/her request uri

``` bash
# curl to the reverse-proxy container
curl localhost:8000/i-love-devops
```

## reverse-proxy-prefix

- in this scenario we have a reverse proxy in fron of a backend service and proxy the request to our backend and respond to the client via his/her request uri but here we intercept the uri

``` bash
curl localhost:8000/v2/customers/ANDBD9n7jlQwxTScIAuK/devops
# leads to -> version: 1, customer-id: ANDBD9n7jlQwxTScIAuK, uri: devops

curl localhost:8000/custon-name/devops
# leads to -> no version, uri: /custon-name/devops
```

## load-balancing

- in this scenario we have a reverse proxy in fron of a 2 backend services and proxy the request to our backends based on the defined upstream

- here we used `static ip` in compose file to use them in loadbalancing.

``` bash
# hit the load balancer
curl localhost:8000
```

- here we want to use Apache HTTP server benchmarking tool named `ab` to test how many times we hit backend-1 and how many times backend-2 has been hitted with corresponding ip addresses of 8001 and 8002

``` bash
ab -n 100 -v 4 http://127.0.0.1:8000/ | grep 'requesting to server with port:' | sort | uniq -c
#  75 requesting to server with port: 8001
#  25 requesting to server with port: 8002
```

## rate-limit

- in this scenario we try to implement a reverse proxy that forbid the requests that are extra our defined limits.

``` nginx
limit_req_zone $binary_remote_addr zone=limit:10m rate=10r/s;
# Key: Defines the request characteristic
# Zone: store the state of each IP address and how often it has accessed a request‑limited URL
# Rate: maximum request rate

limit_req zone=mylimit burst=10 nodelay;
# burst: how many requests a client can make in excess of the rate specified by the zone
# nodelay: allocates slots in the queue according to the burst parameter and imposes the configured rate limit
```

``` bash
# hit the load balancer
curl localhost:8000
```

- here we use `ab` to test rate-limit of the reverse-proxy

``` bash
ab -n 20 -v 4 http://127.0.0.1:8000/ 
#  Non-2xx responses:      9 (503 status code)
```

## log

- in this scenario we try to change the default log format and apply our custom one.

``` bash
# hit the reverse proxy 5 times
for i in {1..5}; do curl localhost:8000/salam; done

# run bash inside backend
docker exec -it backend bash

# run bash inside backend
docker exec -it backend cat /var/log/nginx/acceess.log

# files are just symbolic links to the device files /dev/stdout and /dev/stderr. 
# That's why you can't see any updates to them
# so get the logs via docker logs
docker logs backend
```
