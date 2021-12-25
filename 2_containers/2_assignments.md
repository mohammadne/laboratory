docker container run -d -p 3306:3306 db -e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker container logs db
docker container run -d --name webserver -p 8080:80 httpd
docker container ls
docker container run -d --name proxy -p 80:80 nginx
docker container ls
curl localhost
curl localhost:8080
curl localhost:3306
docker container stop db webserver proxy
docker container rm db webserver proxy
docker container ls -a
docker image ls 
