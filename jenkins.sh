#!/bin/bash
sudo apt update && sudo apt install openjdk-8-jdk -y
sudo java -version
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get install jenkins -y

#---------------------------------High-Availability----------------------------------------------------------------

reloadconfig user API Token - 110de73dcec71840cded4f643cd3b7ebac

#Download Jenkins CLI on both Primary and Secondary Servers (If loadbalancing used else secondary is enough)
wget http://ec2-3-238-93-44.compute-1.amazonaws.com:8080/jnlpJars/jenkins-cli.jar

#Add this to crontab on Secondary (Also on Primary If Loadbalancing is used)
java -jar /root/jenkins-cli.jar -s http://ec2-3-238-93-44.compute-1.amazonaws.com:8080 -auth reloadconfig:110de73dcec71840cded4f643cd3b7ebac reload-configuration 

#-------------------------------------Jenkins-in-Docker------------------------------------------------------------
https://www.jenkins.io/doc/book/installing/docker/