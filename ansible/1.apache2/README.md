# Apache2

``` bash
# ping the hosts
ansible webservers -i inventory.ini -m ping # webservers's hosts
ansible all -i inventory.ini -m ping # all the hosts

# run the playbook
ansible-playbook -i inventory.ini playbook.yml
```
