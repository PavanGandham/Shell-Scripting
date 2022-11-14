#!/bin/bash

# Step 1 — Installing Docker Compose
# download the 1.29.2 release and save the executable file at /usr/local/bin/docker-compose, 
# which will make this software globally accessible as docker-compose:
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# set the correct permissions so that the docker-compose command is executable:
sudo chmod +x /usr/local/bin/docker-compose

# verify that the installation was successful, you can run:
docker-compose --version

# Step 2 — Setting Up a docker-compose.yml File
touch docker-compose.yml
echo "version: '3.7'
services:
  web:
    image: nginx:alpine
    ports:
      - "8000:80"
    volumes:
      - ./app:/usr/share/nginx/html" | > docker-compose.yml

# Step 3 — Running Docker Compose
docker-compose up -d
docker-compose ps
docker-compose logs
docker-compose pause
docker-compose unpause
docker-compose stop
docker-compose down