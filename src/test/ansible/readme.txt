for ansible

[testing-vm]
testpetclinic.westeurope.cloudapp.azure.com ansible_user=adminuser ansible_ssh_private_key_file=/home/alan/.ssh/testvmkey VERSION=

[acceptance-vm]
xptpetclinic.westeurope.cloudapp.azure.com ansible_user=adminuser ansible_ssh_private_key_file=/home/alan/.ssh/acceptvm VERSION=

[production-vm]
prodpetclinic.westeurope.cloudapp.azure.com ansible_user=adminuser ansible_ssh_private_key_file=/home/alan/.ssh/productionvm VERSION=

example login via terminal:

ssh -i .ssh/testvmkey  adminuser@testpetclinic.westeurope.cloudapp.azure.com
