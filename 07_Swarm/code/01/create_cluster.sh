# Naming by file /etc/hosts
192.168.0.40  swarm-4 SWARM-4
192.168.0.49  swarm-3 SWARM-3
192.168.0.48  swarm-2 SWARM-2
192.168.0.56  swarm-1 SWARM-1

# Install localization 
sudo apt -y install language-pack-it ; sudo locale-gen it_IT.UTF-8; \
ssh ubuntu@swarm-2 "sudo apt -y install language-pack-it ; sudo locale-gen it_IT.UTF-8"; \
ssh ubuntu@swarm-3 "sudo apt -y install language-pack-it ; sudo locale-gen it_IT.UTF-8"; \
ssh ubuntu@swarm-4 "sudo apt -y install language-pack-it ; sudo locale-gen it_IT.UTF-8";

# Update package db and upgrade package
sudo apt update ; sudo apt -y upgrade; \
ssh ubuntu@swarm-2 "sudo apt update ; sudo apt -y upgrade"; \
ssh ubuntu@swarm-3 "sudo apt update ; sudo apt -y upgrade"; \
ssh ubuntu@swarm-4 "sudo apt update ; sudo apt -y upgrade";

# Reboot
ssh ubuntu@swarm-2 "sudo shutdown -r now"; \
ssh ubuntu@swarm-3 "sudo shutdown -r now"; \
ssh ubuntu@swarm-4 "sudo shutdown -r now"; \
sudo shutdown -r now

#Install depends package
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common; \
ssh ubuntu@swarm-2 "sudo apt -y install apt-transport-https ca-certificates curl software-properties-common"; \
ssh ubuntu@swarm-3 "sudo apt -y install apt-transport-https ca-certificates curl software-properties-common"; \
ssh ubuntu@swarm-4 "sudo apt -y install apt-transport-https ca-certificates curl software-properties-common"; 

# download docker repo key and install repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - ; \
ssh ubuntu@swarm-2 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"; \
ssh ubuntu@swarm-3 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"; \
ssh ubuntu@swarm-4 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"; 

# check docker repo key
sudo apt-key fingerprint 0EBFCD88 ; \
ssh ubuntu@swarm-2 "sudo apt-key fingerprint 0EBFCD88"; \
ssh ubuntu@swarm-3 "sudo apt-key fingerprint 0EBFCD88"; \
ssh ubuntu@swarm-4 "sudo apt-key fingerprint 0EBFCD88"; 

# Install docker official repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"; \
ssh ubuntu@swarm-2 "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\""; \
ssh ubuntu@swarm-3 "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\""; \
ssh ubuntu@swarm-4 "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\""; 

# Install Docker Community Edition
sudo apt -y update ; sudo apt -y install docker-ce; \
ssh ubuntu@swarm-2 "sudo apt -y update ; sudo apt -y install docker-ce"; \
ssh ubuntu@swarm-3 "sudo apt -y update ; sudo apt -y install docker-ce"; \
ssh ubuntu@swarm-4 "sudo apt -y update ; sudo apt -y install docker-ce"; 

sudo apt -y dist-upgrade; \
ssh ubuntu@swarm-2 "sudo apt -y dist-upgrade"; \
ssh ubuntu@swarm-3 "sudo apt -y dist-upgrade"; \
ssh ubuntu@swarm-4 "sudo apt -y dist-upgrade"; 

# Enable ubuntu user to use docker
sudo groupadd docker; sudo usermod -aG docker $USER; \
ssh ubuntu@swarm-2 "sudo groupadd docker; sudo usermod -aG docker \$USER"; \
ssh ubuntu@swarm-3 "sudo groupadd docker; sudo usermod -aG docker \$USER"; \
ssh ubuntu@swarm-4 "sudo groupadd docker; sudo usermod -aG docker \$USER"; 

sudo apt -y install jq; \
ssh ubuntu@swarm-2 "sudo apt -y install jq"; \
ssh ubuntu@swarm-3 "sudo apt -y install jq"; \
ssh ubuntu@swarm-4 "sudo apt -y install jq"; 


sudo apt -y autoremove; \
ssh ubuntu@swarm-2 "sudo apt -y autoremove";\
ssh ubuntu@swarm-3 "sudo apt -y autoremove";\
ssh ubuntu@swarm-4 "sudo apt -y autoremove";

# Reboot
ssh ubuntu@swarm-2 "sudo shutdown -r now"; \
ssh ubuntu@swarm-3 "sudo shutdown -r now"; \
ssh ubuntu@swarm-4 "sudo shutdown -r now"; \
sudo shutdown -r now



ssh ubuntu@swarm-4 "docker swarm init;"; 
ssh ubuntu@swarm-2 "docker swarm join --token SWMTKN-1-302sumb1nyvqmk5m7ui30anb1o6qzqbqlfipv8sc3m931d0fyl-5n2adgcl33g1yq20c5o57hsn3 192.168.0.40:2377"; \
ssh ubuntu@swarm-3 "docker swarm join --token SWMTKN-1-302sumb1nyvqmk5m7ui30anb1o6qzqbqlfipv8sc3m931d0fyl-5n2adgcl33g1yq20c5o57hsn3 192.168.0.40:2377"; \
docker swarm join --token SWMTKN-1-302sumb1nyvqmk5m7ui30anb1o6qzqbqlfipv8sc3m931d0fyl-636z75vrkmzjtcl9ffe8npkpj 192.168.0.40:2377

ssh ubuntu@swarm-2 "docker swarm leave"; \
ssh ubuntu@swarm-3 "docker swarm leave"; \
ssh ubuntu@swarm-4 "docker swarm leave"; 

docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer

Applicazione di Esempio: https://github.com/dockersamples/example-voting-app

Frontend(Visualizzatore): http://90.147.188.93:5001/
Backend(Espressione di voto): http://90.147.188.93:5000/
visualizer(Visualizzatore): http://90.147.188.93:8080/