#!/bin/bash -xe

# Step 1 — Installing Jenkins

# Ensure that your software packages are up to date on your instance
sudo apt update

# First, add the repository key to the system
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# When the key is added, the system will return OK. 
# Next, append the Debian package repository address to the server’s sources.list:
# echo 'deb https://pkg.jenkins.io/debian-stable binary/' >> /etc/apt/sources.list

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update

# Install Java JDK 8  
sudo apt install openjdk-8-jdk -y

# Check Java Version
sudo java -version

# Install Jenkins and its dependencies
sudo apt install jenkins -y

# Step 2 — Starting Jenkins

# Stating Jenkins Server
sudo systemctl start jenkins

# Verify the Status of Jenkins Server
sudo systemctl status jenkins

# Enable Jenkins server to start at boot
sudo systemctl enable jenkins

# Step 3 — Opening the Firewall

# Open Port 8080 on ufw for jenkins 
sudo ufw allow 8080
# check the ufw satus 
sudo ufw status

# If the ufw is inactive the below commands allows openssh and enable ufw
sudo ufw allow OpenSSH
sudo ufw enable

#---------------------------------High-Availability----------------------------------------------------------------

#Create a jenkins user example reloadconfig and login with theat user and create a token which is used o reload the config
#rather than restarting the server. Make sure you have restarted the secondary jenkins service so that user is visible to secondary

# On the Secondary create a cron scheduler as below
# change the user as jenkins using su - jenkins
# Copy jenkins-cli.jar to jenkins home folder which is /var/lib/jenkins

# crontab -e
# reloadconfig user API Token - 110de73dcec71840cded4f643cd3b7ebac

#Download Jenkins CLI on both Primary and Secondary Servers (If loadbalancing used else secondary is enough)
#wget http://ec2-3-238-93-44.compute-1.amazonaws.com:8080/jnlpJars/jenkins-cli.jar

#Add this to crontab on Secondary (Also on Primary If Loadbalancing is used)
#                                    <Secondary- Server IP>
#java -jar /root/jenkins-cli.jar -s http://ec2-3-238-93-44.compute-1.amazonaws.com:8080 -auth reloadconfig:110de73dcec71840cded4f643cd3b7ebac reload-configuration 

# crontab -l
# <mkcert>
# wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64
# mv mkcert-v1.4.4-linux-amd64 mkcert
# chmod 700 mkcert
# ./mkcert "*.pavank8s.ml"
# cat _wildcard.pavank8s.ml.pem > pavank8s.ml-fullchain.pem
# cat /root/.local/share/mkcert/rootCA.pem >> pavank8s.ml-fullchain.pem

# <Primary-Server>
# wget http://ec2-34-228-61-142.compute-1.amazonaws.com:8080/jnlpJars/jenkins-cli.jar

# crontab -e

# * * * * * java -jar /root/Jenkins-Primary/jenkins-cli.jar -s http://ec2-35-173-178-160.compute-1.amazonaws.com:8080 -auth reloadconfig:11c76a1c5954bc10d048c0b7b71836d467 reload-configuration


#-------------------------------------Jenkins-in-Docker------------------------------------------------------------
#https://www.jenkins.io/doc/book/installing/docker/