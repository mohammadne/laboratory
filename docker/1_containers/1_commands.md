## Nginx
basic configurable web-server, easy to use and powerful
it has master and worker processes for its load-balancer

## version => verify `cli` can talk to `engine`
- docker version

### important note
- `client` also will be called `cli`
- `server` also will be called `engine` or `deamon`

## Display system-wide information and most configuration values for the engine
- docker info

## list all commands
- docker

## command format
- docker <managment-command> <sub-command> (options)

<!-- Start a new container from an image -->
- docker container run => new
- docker run => old

## Image vs Container
image => binaries, libraries and source code (application we want to run)
container => instance of running image as a process
- you can have many conainers running of same image

## download an image
- docker pull <image-name>
- docker pull alpine

## get nginx image and run it in foreground
- docker container run --publish 80:80 nginx 
it will run nginx image (create a new process for it in background), 
to check its available, type localhost in your browser

publish will expose port 80 (left-side) on local machine and sends traffic
into port 80 (right-side) of the running container, suppose we have a request
from port 80 (left side) of localhost from web browser, then our local machine will transmit
the traffic into port 80 (right side) of the container

note: you will get bind error if left number (host port) is being used by anything else
even another container, use any port on left like 8080 then type localhost:8080
in browser for testing purposes.

## get nginx image (if there isn't downloaded) and run it in background
- docker container run --publish 80:80 --detach nginx
- docker container run --publish 80:80 -d nginx

if we run it in foreground (without --detach flag), by exiting terminal 
the container will quite, so we will run it in background

## give a custom name to a container
- docker container run --publish 80:80 -d --name webhost nginx

## list all running containers
- docker container ls
- docker ps (old)
- docker container ls | grep nginx | grep name

## list all containers (include running)
- docker container ls -a


## stop a (running) container via its ID (from background)
- docker container stop ID

each running instance of container, have a unique id

## start a (stopped) container via its name (from background)
- docker container start <name-or-id-of-a-container>

## start vs run
- run: will create (pull or cache) container from an image and start it
- start: can only start stopped containers

## to see in background logs of container 
- docker container logs <name-of-container>

## display the running processes of a container
- docker container top <name-of-container>

## Remove one or more containers
- docker container rm <container-id>
- docker container rm -f <container-id>
- docker container rm <id-1> <id-2> <id-3>

## what happens when we run: docker container run
1- Looks for that image locally in image cache then on remote image repository (default to `Docker-Hub`)
2- By default will download `latest` version (image:latest)
3- Crate new container based on that image and prepare to start
4- gives it a `virtual IP` on a private network inside `docker-engine`
5- opens port 80 on host and forwards to port 80 in container
6- starts container by using `CMD` in image `Dockerfile`

### impotant note
if we don't specify publish ports, 
then it will not expose any port on local machine
and forwards the traffic into it.


## Containers vs VMs:
containers are just restricted processes inside host OS
containers aren't mini VM's

## list processes that are running in a specific container
- docker container top <name-of-container>

## list all running processes on Host-OS
- ps aux

running proccesses of a container, is also part of host-os processes,

## list all running processes with filtering
- ps aux | grep <name-of-container>

## passing environment variables (--env or -e)
- docker container run -d -p 3306:3306 db -e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql

### note
in case of mysql, use container logs to findout random-password

