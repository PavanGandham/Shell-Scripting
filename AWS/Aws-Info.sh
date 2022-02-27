#------------------------------Vpc-Subnets--------------------------------------------------------------------
#!/bin/bash
for vpc in $(aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"'); do
    echo "Getting Subnet Id info for $vpc"
    aws ec2 describe-subnets --filters "Name=vpc-id,Value=$vpc" | jq "Subnets[].SubnetId"
    echo "====================================================="
    sleep 1
done
#---------------------------------AWS-Infrastructure-Info---------------------------------------------------
#!/bin/bash
# Get VPC Information
Region='us-east-1'
echo "Getting VPC info in ${Region} !!!"
aws ec2 describe-vpcs --region $Region | jq ".Vpcs[].VpcId"
echo "------------------------------------------------------------------"
# Get S3 Bucket Information
echo "Getting info of S3 Buckets in ${Region} !!!"
aws s3 ls --region ${Region}
echo "------------------------------------------------------------------"
# Get EC2 Information
echo "Getting info of EC2 Instances in ${Region} !!!"
aws ec2 describe-instances --region $Region | jq ".Reservations[].Instances[].InstanceId"
echo "------------------------------------------------------------------"
# Get Route Table Information
echo "Getting Info of Routes in ${Region} !!!"
aws ec2 describe-route-tables --region $Region | jq ".RouteTables[].RouteTableId"