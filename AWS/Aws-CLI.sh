#------------------------------Aws-User-Data-Bootstrap----------------------------------------------------
#!/bin/bash
sudo apt update -y
sudo apt install jq -y
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
echo "export AWS_ACCESS_KEY_ID=*************" >>.bashrc
echo "export AWS_SECRET_ACCESS_KEY=*******************" >>.bashrc
echo "export AWS_DEFAULT_REGION=us-east-1" >>.bashrc
source .bashrc

#-----------------------------------------------------------------------------------------------------------
aws lambda list-functions | grep function:create_pre_signed_url | cut -f2- -d: | tr -d "," | xargs
bucket=$(aws s3api list-buckets --query "Buckets[].Name" | grep s3bucket | tr -d ',' | sed -e 's/"//g' | xargs)