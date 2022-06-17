#!/bin/bash

# Step 1: Create a Docker image
touch Dockerfile
echo 'FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && \
 apt-get -y install apache2

# Install apache and write hello world message
RUN echo 'Hello World!' > /var/www/html/index.html

# Configure apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh' >> Dockerfile

docker build -t hello-world .
docker images --filter reference=hello-world
docker run -t -i -p 80:80 hello-world
docker-machine ip machine-name

# Step 2: Authenticate to your default registry
aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com

# Step 3: Create a repository
aws ecr create-repository \
    --repository-name hello-world \
    --image-scanning-configuration scanOnPush=true \
    --region region

# Step 4: Push an image to Amazon ECR
docker tag hello-world:latest aws_account_id.dkr.ecr.region.amazonaws.com/hello-world:latest
docker push aws_account_id.dkr.ecr.region.amazonaws.com/hello-world:latest

# Step 5: Pull an image from Amazon ECR
docker pull aws_account_id.dkr.ecr.region.amazonaws.com/hello-world:latest

# Step 6: Delete an image
aws ecr batch-delete-image \
      --repository-name hello-world \
      --image-ids imageTag=latest \
      --region region

# Step 7: Delete a repository
aws ecr delete-repository \
      --repository-name hello-world \
      --force \
      --region region
