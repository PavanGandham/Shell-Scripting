#!/bin/bash

# How To Install Apache Tomcat 9 on Ubuntu 18.04

# Prerequisites
# required a non-root user with sudo privileges 

# Step 1 — Install Java
sudo apt update
sudo apt install default-jdk -y

# Step 2 — Create Tomcat User
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# Step 3 — Install Tomcat
cd /tmp
# copy tar.gz file link from this downloads url https://tomcat.apache.org/download-90.cgi
    curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/embed/apache-tomcat-9.0.65-embed.tar.gz
    sudo mkdir /opt/tomcat
    sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1

# Step 4 — Update Permissions
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat

sudo chmod -R g+r conf
sudo chmod g+x conf

sudo chown -R tomcat webapps/ work/ temp/ logs/

# Step 5 — Create a systemd Service File

sudo update-java-alternatives -l

export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

sudo nano /etc/systemd/system/tomcat.service

[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat

# Step 6 — Adjust the Firewall and Test the Tomcat Server
sudo ufw allow 8080

# Open in web browser
# http://server_domain_or_IP:8080

sudo systemctl enable tomcat

# Step 7 — Configure Tomcat Web Management Interface
sudo nano /opt/tomcat/conf/tomcat-users.xml

<tomcat-users>
    # <user username="admin" password="password" roles="manager-gui,admin-gui"/>
    <role rolename="admin-gui,manager-gui,manager-script,manager-jmx,manager-status,admin-gui"/>
    <user username="admin" password="password" roles="admin-gui,manager-gui,manager-script"/>
</tomcat-users>


# To change the IP address restrictions on these, open the appropriate context.xml files.

# For the Manager app, type:
sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml

# For the Host Manager app, type:
sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml

# context.xml files for Tomcat webapps

<Context antiResourceLocking="false" privileged="true" >
    <!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
        allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
    -->
</Context>

sudo systemctl restart tomcat

# Step 8—Access the Web Interface

# Open in web browser
# http://server_domain_or_IP:8080
# Manager App, accessible via the link or http://server_domain_or_IP:8080/manager/html
# Host Manager, accessible via the link or http://server_domain_or_IP:8080/host-manager/html/