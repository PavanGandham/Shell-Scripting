#!/bin/bash

# sudo apt update
# sudo apt install maven
# mvn -version

# 1. Install OpenJDK
sudo apt update
sudo apt install default-jdk
java -version

# 2. Downloading Apache Maven
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.6.3 /opt/maven

# 3. Setup environment variables 
# sudo nano /etc/profile.d/maven.sh
echo 'export JAVA_HOME=/usr/lib/jvm/default-java
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
' >> /etc/profile.d/maven.sh

sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

# 4. Verify the installation
mvn -version

