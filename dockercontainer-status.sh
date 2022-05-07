#!/bin/bash

# Docker: Check Container Existence and Status

# Step-1 : Check if a Docker container exists
# Start a test container and check status
# docker run -it --name testContainer alpine:latest ash
# docker ps
CONTAINER_NAME=$(docker ps -a | awk '{print $3}' )
if [[ $(docker ps -a | grep ) ]]