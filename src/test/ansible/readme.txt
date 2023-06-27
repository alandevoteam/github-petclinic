for ansible NOTES

[testing-vm]
testpetclinic.westeurope.cloudapp.azure.com ansible_user=adminuser ansible_ssh_private_key_file=/home/alan/.ssh/testvmkey VERSION=

[acceptance-vm]
xptpetclinic.westeurope.cloudapp.azure.com ansible_user=adminuser ansible_ssh_private_key_file=/home/alan/.ssh/acceptvm VERSION=

[production-vm]
prodpetclinic.westeurope.cloudapp.azure.com ansible_user=adminuser ansible_ssh_private_key_file=/home/alan/.ssh/productionvm VERSION=

example login via terminal:
ssh -i .ssh/testvmkey  adminuser@testpetclinic.westeurope.cloudapp.azure.com


ansible-playbook -i ~/actions-runner/_work/github-petclinic/github-petclinic/src/test/ansible/inventory.ini --ask-pass --ask-become-pass --extra-vars "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" ~/actions-runner/_work/github-petclinic/github-petclinic/src/test/ansible/playbook_testing.yml

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ~/actions-runner/_work/github-petclinic/github-petclinic/src/test/ansible/inventory.ini --extra-vars "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" --ask-pass ~/actions-runner/_work/github-petclinic/github-petclinic/src/test/ansible/playbook_testing.yml
