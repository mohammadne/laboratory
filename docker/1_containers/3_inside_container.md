## start 2 common containers
- docker container run -d --name nginx nginx
- docker container run -d --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql
- docker container ls
- docker container top mysql
- docker container top nginx

## Display the running processes of a container
- docker container top <container-name>

## Display a live stream of container(s) resource usage statistics
- docker container stats <container-name>

## Display detailed information on one or more containers (env and options)
- docker container inspect <container-name>

## get-into a container and do stuffs live (start interactively)
- docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]
after IMAGE name we'll pass args that are default args to start image with it.

- docker container run -it --name proxy nginx bash (if not exists)
- docker container start -ai proxy (if stopped)

-t => `pseudo-tty` to simulate a real terminal like what SSH does
-i => `interactive` to keep STDIN open (keep session open to recieve more commands)
-it (both) => give you a shell inside the running container

images have default configs, configs tells containers what to run
if you specify bash, then by existing bash the container will be stop
because the container will be spawn by running this command as first arg

## run additional commands in a running container (add another process into it)
suppose you have running mysql before and then by doing:
- docker container exec -it mysql bash

you can install ps on mysql-container by running (it's a raw linux distro):
- apt-get install && apt-get install -y procps

## list all pulled images
- docker image ls

we can only only use existing tools in an image, not in Host 
- docker container run -it --name alpine  alpine sh
