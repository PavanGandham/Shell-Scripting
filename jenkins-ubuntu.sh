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

# reloadconfig user API Token - 110de73dcec71840cded4f643cd3b7ebac

#Download Jenkins CLI on both Primary and Secondary Servers (If loadbalancing used else secondary is enough)
#wget http://ec2-3-238-93-44.compute-1.amazonaws.com:8080/jnlpJars/jenkins-cli.jar

#Add this to crontab on Secondary (Also on Primary If Loadbalancing is used)
#java -jar /root/jenkins-cli.jar -s http://ec2-3-238-93-44.compute-1.amazonaws.com:8080 -auth reloadconfig:110de73dcec71840cded4f643cd3b7ebac reload-configuration 

#-------------------------------------Jenkins-in-Docker------------------------------------------------------------
#https://www.jenkins.io/doc/book/installing/docker/