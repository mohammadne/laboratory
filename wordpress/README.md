# Wordpress

> setup 2 VMs, one as a control-machine (name it `master`) 
>
> the other one as the guest VM that we want to control it via ansible (name it `slave`) 

## on master

``` bash
# add <ip-address-of-slave> slave
# entry to the hosts
sudo nano /etc/hosts

# ping slave and test if it works
ping slave

# install ansible
sudo apt install ansible -y

# check ansible is running by
ansible localhost -m command -a hostname

# create SSH-key
ssh-keygen -t ed25519 -C "master@domain.com"

# copy public ssh key
cat ~/.ssh/id_ed25519.pub

# paste public ssh key to the authorized_hosts of the slave
vi ~/.ssh/authorized_keys

# issue the ping command to the slave to test the connection
ansible webapp -i hosts -m command -a hostname  -u slave
``` 