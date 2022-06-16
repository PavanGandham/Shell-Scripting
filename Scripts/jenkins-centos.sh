#!/bin/bash -xe

# Step-1 : Download and install Jenkins

# To ensure that your software packages are up to date on your instance:
sudo yum update -y

# Add the Jenkins repo:
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import a key file from Jenkins-CI to enable installation from the package:
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y 

# Install Java:
# sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install -y java-openjdk11
# Install Jenkins:
sudo yum install jenkins -y

# Enable the Jenkins service to start at boot:
sudo systemctl enable jenkins

# Start Jenkins as a service:
sudo systemctl start jenkins

# You can check the status of the Jenkins service using the command:
sudo systemctl status jenkins