#!/bin/bash

# Installing Docker on Ubuntu 20.04
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce -y
echo '#############################################-Docker installed-#############################################' >> /usr/local/src/ansible_playground_script_log.txt
sudo systemctl status docker | head -10 >> /usr/local/src/ansible_playground_script_log.txt



#Install Docker Compose on Ubuntu 20.04
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo '##########################################-docker-compose installed-##########################################' >> /usr/local/src/ansible_playground_script_log.txt
docker-compose --version >> /usr/local/src/ansible_playground_script_log.txt



#Install Python 3.9 on Ubuntu 20.04
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.9 -y
echo '##########################################-python3.9 installed-##########################################' >> /usr/local/src/ansible_playground_script_log.txt
python3.9 --version >> /usr/local/src/ansible_playground_script_log.txt



#Install Ansible on Ubuntu 20.04
sudo apt install ansible -y
echo '##########################################-ansible installed-##########################################' >> /usr/local/src/ansible_playground_script_log.txt
ansible --version >> /usr/local/src/ansible_playground_script_log.txt



#Creating ssh-keygen [this need to be done before using Ansible-playground setup]
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y
echo '##################################-id_rsa.pub created under id_rsa.pub-##################################' >> /usr/local/src/ansible_playground_script_log.txt
cat ~/.ssh/id_rsa.pub >> /usr/local/src/ansible_playground_script_log.txt



#Port 2222 need to be opened for local host, as of now no issues in Ubuntu 20.04, in case found any issues need to check 


#Creating Ansible-playground using Docker
mkdir ~/MAGIC
cd ~/MAGIC
git clone https://github.com/kbairak/ansible-playground
cd ansible-playground
apt install make -y
make
#Creating node1 node2 in docker container
./bin/add_host node1
./bin/add_host node2
make up


echo '##############################-Ansible to node1&node2 connection checking-##############################' >> /usr/local/src/ansible_playground_script_log.txt
ansible node1 -m ping >>  /usr/local/src/ansible_playground_script_log.txt
ansible node2 -m ping >>  /usr/local/src/ansible_playground_script_log.txt





