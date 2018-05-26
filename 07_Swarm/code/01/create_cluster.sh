# Public IP - Entrypoint
ssh -A debian@90.147.188.165
ssh -A debian@90.147.188.137

# Naming by file /etc/hosts
sudo /bin/sh -c 'printf "192.168.0.90\tswarm-4\tSWARM-4\n192.168.0.107\tswarm-3\tSWARM-3\n192.168.0.100\tswarm-2\tSWARM-2\n192.168.0.104\tswarm-1\tSWARM-1\n" >> /etc/hosts'; \
ssh -t debian@swarm-2 "sudo /bin/sh -c 'printf \"192.168.0.90\tswarm-4\tSWARM-4\n192.168.0.107\tswarm-3\tSWARM-3\n192.168.0.100\tswarm-2\tSWARM-2\n192.168.0.104\tswarm-1\tSWARM-1\n\" >> /etc/hosts'"; \
ssh -t debian@swarm-3 "sudo /bin/sh -c 'printf \"192.168.0.90\tswarm-4\tSWARM-4\n192.168.0.107\tswarm-3\tSWARM-3\n192.168.0.100\tswarm-2\tSWARM-2\n192.168.0.104\tswarm-1\tSWARM-1\n\" >> /etc/hosts'"; \
ssh -t debian@swarm-4 "sudo /bin/sh -c 'printf \"192.168.0.90\tswarm-4\tSWARM-4\n192.168.0.107\tswarm-3\tSWARM-3\n192.168.0.100\tswarm-2\tSWARM-2\n192.168.0.104\tswarm-1\tSWARM-1\n\" >> /etc/hosts'"; 

# Install localization 
sudo localedef -i it_IT -f UTF-8 it_IT.UTF-8 ; sudo localectl set-locale LANG="it_IT.UTF8"; \
ssh -t debian@swarm-2 "sudo localedef -i it_IT -f UTF-8 it_IT.UTF-8 ; sudo localectl set-locale LANG=\"it_IT.UTF8\" "; \
ssh -t debian@swarm-3 "sudo localedef -i it_IT -f UTF-8 it_IT.UTF-8 ; sudo localectl set-locale LANG=\"it_IT.UTF8\" "; \
ssh -t debian@swarm-4 "sudo localedef -i it_IT -f UTF-8 it_IT.UTF-8 ; sudo localectl set-locale LANG=\"it_IT.UTF8\" "

# Set timezone
sudo timedatectl set-timezone Europe/Rome; \
ssh -t debian@swarm-2 "sudo timedatectl set-timezone Europe/Rome"; \
ssh -t debian@swarm-3 "sudo timedatectl set-timezone Europe/Rome"; \
ssh -t debian@swarm-4 "sudo timedatectl set-timezone Europe/Rome"; 

# Update package db and upgrade package
sudo apt update ; sudo apt -y upgrade; \
ssh -t debian@swarm-2 "sudo apt update ; sudo apt -y upgrade"; \
ssh -t debian@swarm-3 "sudo apt update ; sudo apt -y upgrade"; \
ssh -t debian@swarm-4 "sudo apt update ; sudo apt -y upgrade";

# Reboot
ssh -t debian@swarm-2 "sudo shutdown -r now"; \
ssh -t debian@swarm-3 "sudo shutdown -r now"; \
ssh -t debian@swarm-4 "sudo shutdown -r now"; \
sudo shutdown -r now

#Install depends package
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common; \
ssh -t debian@swarm-2 "sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common"; \
ssh -t debian@swarm-3 "sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common"; \
ssh -t debian@swarm-4 "sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common"; 

# download docker repo key and install repo
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - ; \
ssh -t debian@swarm-2 "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -"; \
ssh -t debian@swarm-3 "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -"; \
ssh -t debian@swarm-4 "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -"; 

# check docker repo key
sudo apt-key fingerprint 0EBFCD88 ; \
ssh -t debian@swarm-2 "sudo apt-key fingerprint 0EBFCD88"; \
ssh -t debian@swarm-3 "sudo apt-key fingerprint 0EBFCD88"; \
ssh -t debian@swarm-4 "sudo apt-key fingerprint 0EBFCD88"; 

# Install docker official repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"; \
ssh -t debian@swarm-2 "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian \$(lsb_release -cs) stable\""; \
ssh -t debian@swarm-3 "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian \$(lsb_release -cs) stable\""; \
ssh -t debian@swarm-4 "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian \$(lsb_release -cs) stable\""; 

sudo add-apt-repository -r "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"; \
ssh -t debian@swarm-2 "sudo add-apt-repository -r \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\""; \
ssh -t debian@swarm-3 "sudo add-apt-repository -r \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\""; \
ssh -t debian@swarm-4 "sudo add-apt-repository -r \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\""; 


# Install Docker Community Edition
sudo apt -y update ; sudo apt -y install docker-ce; \
ssh -t debian@swarm-2 "sudo apt -y update ; sudo apt -y install docker-ce"; \
ssh -t debian@swarm-3 "sudo apt -y update ; sudo apt -y install docker-ce"; \
ssh -t debian@swarm-4 "sudo apt -y update ; sudo apt -y install docker-ce"; 

sudo apt -y dist-upgrade; \
ssh -t debian@swarm-2 "sudo apt -y dist-upgrade"; \
ssh -t debian@swarm-3 "sudo apt -y dist-upgrade"; \
ssh -t debian@swarm-4 "sudo apt -y dist-upgrade"; 

# Enable debian user to use docker
sudo groupadd docker; sudo usermod -aG docker $USER; \
ssh -t debian@swarm-2 "sudo groupadd docker; sudo usermod -aG docker \$USER"; \
ssh -t debian@swarm-3 "sudo groupadd docker; sudo usermod -aG docker \$USER"; \
ssh -t debian@swarm-4 "sudo groupadd docker; sudo usermod -aG docker \$USER"; 

# Add settings to grub
sudo vi /etc/default/grub
Change in /etc/default/grub this line
GRUB_CMDLINE_LINUX_DEFAULT="biosdevname=0 net.ifnames=0..."
with
GRUB_CMDLINE_LINUX_DEFAULT="cgroup_enable=memory swapaccount=1 biosdevname=0 net.ifnames=0..."
sudo update-grub
to update grub configuration.


sudo apt -y install jq htop; \
ssh -t debian@swarm-2 "sudo apt -y install jq htop"; \
ssh -t debian@swarm-3 "sudo apt -y install jq htop"; \
ssh -t debian@swarm-4 "sudo apt -y install jq htop"; 


sudo apt -y autoremove; \
ssh -t debian@swarm-2 "sudo apt -y autoremove";\
ssh -t debian@swarm-3 "sudo apt -y autoremove";\
ssh -t debian@swarm-4 "sudo apt -y autoremove";

# Reboot
ssh -t debian@swarm-2 "sudo shutdown -r now"; \
ssh -t debian@swarm-3 "sudo shutdown -r now"; \
ssh -t debian@swarm-4 "sudo shutdown -r now"; \
sudo shutdown -r now

ssh -t debian@swarm-4 "docker swarm init;"; 
ssh -t debian@swarm-2 "docker swarm join --token SWMTKN-1-302sumb1nyvqmk5m7ui30anb1o6qzqbqlfipv8sc3m931d0fyl-5n2adgcl33g1yq20c5o57hsn3 swarm-4:2377"; \
ssh u-t debian@swarm-3 "docker swarm join --token SWMTKN-1-302sumb1nyvqmk5m7ui30anb1o6qzqbqlfipv8sc3m931d0fyl-5n2adgcl33g1yq20c5o57hsn3 swarm-4:2377"; \
docker swarm join --token SWMTKN-1-302sumb1nyvqmk5m7ui30anb1o6qzqbqlfipv8sc3m931d0fyl-636z75vrkmzjtcl9ffe8npkpj swarm-4:2377

ssh -t debian@swarm-2 "docker swarm leave"; \
ssh -t debian@swarm-3 "docker swarm leave"; \
ssh -t debian@swarm-4 "docker swarm leave"; 

docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer

Applicazione di Esempio: https://github.com/dockersamples/example-voting-app

DEMO: 
  http://90.147.188.165:8000/

  http://90.147.188.137:8000/

voting-app:
  Frontend(Visualizzatore): http://90.147.188.165:5001/
  Backend(Espressione di voto): http://90.147.188.165:5000/
  visualizer(Visualizzatore): http://90.147.188.165:8080/
  redis(DB key-value): redis://90.147.188.165:30000/

  Frontend(Visualizzatore): http://90.147.188.137:5001/
  Backend(Espressione di voto): http://90.147.188.137:5000/
  visualizer(Visualizzatore): http://90.147.188.137:8080/
  redis(DB key-value): redis://90.147.188.137:30000/