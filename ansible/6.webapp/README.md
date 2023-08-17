# Webapp

> a lab exercise by walking throw [installing WordPress on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-ubuntu-22-04-with-a-lamp-stack)

## run

``` bash
# test variables are correctly set
ansible -i inventory.ini --ask-vault-pass -m debug -a 'var=hostvars[inventory_hostname]' webapp

# list all the tags
ansible-playbook -i inventory.ini playbook.yml --list-tags

# run the playbook skip php tags
ansible-playbook -i inventory.ini --ask-vault-pass -K playbook.yml --skip-tags "php"

# run all the playbook
ansible-playbook -i inventory.ini --ask-vault-pass -K playbook.yml
```
