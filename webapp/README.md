# Webapp

> a lab exercise by walking throw [installing WordPress on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-ubuntu-22-04-with-a-lamp-stack)

## run

``` bash
# test variables are correctly set
ansible -i hosts --ask-vault-pass -m debug -a 'var=hostvars[inventory_hostname]' webapp

# run the playbook with config tag
ansible-playbook -i hosts --ask-vault-pass -u slave -K playbook.yml --tags config

# run the playbook skip php tags
ansible-playbook -i hosts --ask-vault-pass -u slave -K playbook.yml --skip-tags php

# run all the playbook
ansible-playbook -i hosts --ask-vault-pass -u slave -K playbook.yml
```
