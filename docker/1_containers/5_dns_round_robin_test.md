## intro
here in our network we create w containers with same dns-alias
then by:
- nslookup: returns ip-address of containers with this alias
- curl -s search:9200: route curl request to one of the containers
like a load-balancer

- docker network create dude

- docker container run -d --network dude --network-alias search elasticsearch:7.14.0
- docker container run -d --net dude --net-alias search elasticsearch:7.14.0

- docker container ls

<!-- query Internet name servers -->
- docker container run --rm --net dude alpine nslookup search

- docker container run --rm --net dude ubuntu curl -s search:9200

- docker container rm -f <elasticsearchname-first> <elasticsearchname-second>

