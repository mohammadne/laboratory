# Ansible Lab

<p align="center">
  <img src="assets/logo.jpg" />
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/mohammadne/ansible-lab?style=for-the-badge">
  <img src="https://img.shields.io/github/stars/mohammadne/ansible-lab?style=for-the-badge">
</p>

## setup

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
