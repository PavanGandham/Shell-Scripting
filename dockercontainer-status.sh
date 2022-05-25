#!/bin/bash

# Docker: Check Container Existence and Status

# Step-1 : Check if a Docker container exists
# Start a test container and check status
# docker run -it --name testContainer alpine:latest ash
# docker ps
CONTAINER_NAME=$( docker ps -a | awk '{print $3}' )
if [[ $( docker ps -a -f name=$CONTAINER_NAME | wc -l ) -gt 2 ]]
then
echo "$CONTAINER_NAME exists"
else
echo "$CONTAINER_NAME doesn't exists"

# Docker: Check Docker container status

OUTPUT=$( docker ps -a -f name=$CONTAINER_NAME | grep $CONTAINER_NAME 2> /dev/null )
if [[ ! -z ${OUTPUT}  ]]
then
echo "A container with a name: $CONTAINER_NAME exists and has status: $( echo ${OUTPUT} | awk '{ print $7 }' )"
else
echo "Container with a name: $CONTAINER_NAME does not exist"
fi