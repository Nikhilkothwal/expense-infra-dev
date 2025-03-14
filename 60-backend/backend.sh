#!/bin/bash

dnf install ansible -y
# push
# ansible-playbook -i inventory mysql.yaml

#pull
ansible-pull  -i localhost, -U https://github.com/Nikhilkothwal/ansible-expense-roles-tf.git main.yaml -e component=backend -e environment=$1