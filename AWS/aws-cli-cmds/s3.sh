#!/bin/bash

aws s3api create-bucket \
--acl private \
--bucket pavank8sb12cluster \
--region us-east-1 \


#aws s3 mb s3://mybucket --region us-west-1