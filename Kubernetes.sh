'''
#---------------------------Steps-For-Kubernetes-in-AWS-----------------------------------------------------#
1. Need to buy a Domain from any Domain Registrar.
2. Create a route53 domain zone for your cluster[eg: useast1.dev.example.com].
3. Configure the DNS name servers from Route53 to your Domain Registrar DNS.
4. Deploy an EC2 Linux Machine in AWS and Install KOPS and KUBECTL on it.
5. Create an S3 bucket to save the K8s config/State in it [aws s3 mb s3://clusters.dev.example.com],
 enable Bucket versioning on it [aws s3api put-bucket-versioning --bucket clusters.dev.example.com --versioning-configuration Status=Enabled] and
 use an Environment variable like [KOPS_STATE_STORE=s3://clusters.dev.example.com].
6. Install AWS-CLI if not installed and Create a Access and Secret key with Write access permissions to S3.
7. Create an SSH key-pair by running ssh-keygen to save in /root or /home directory or as below.
 [ssh-keygen -f ~/.ssh/k8sshkey to write ssh-keys into a file ] 
8. Build your cluster configuration / Create the cluster in AWS .
9. List your clusters with: kops get cluster.
10.Edit this cluster with: kops edit cluster useast1.dev.example.com
11.Edit your node instance group: kops edit ig --name=useast1.dev.example.com nodes
12.Edit your master instance group: kops edit ig --name=useast1.dev.example.com master-us-east-1c

'''
#!/bin/bash
#--------------------------------Installing-AWS-CLI(for non-Amazon-Linux-Servers)----------------------------------------------------#

sudo apt update -y
sudo apt install jq -y
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

#-------------------------------Installing-Kubectl-----------------------------------------------------------------------------------#

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 700 kubectl
mv /usr/local/sbin/kubectl

#--------------------------------Installing-Kops-------------------------------------------------------------------------------------#

wget https://github.com/kubernetes/kops/releases/download/v1.20.2/kops-linux-amd64
apt update && apt install unzip -y
chmod 700 kops-linux-amd64
mv kops-linux-amd64 /usr/local/sbin/kops

#----------------------------------Alernate-way---------------------------------------------------------------------------------------#

curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

#-------------------------------------Creating SSH-key-with-Kops---------------------------------------------------------------------#

kops create secret --name=useast1.dev.example.com sshpublickey admin -i ~/.ssh/id_rsa.pub

#--------------------------------------Creating-K8s-Cluster[Single-Zone]-------------------------------------------------------------#

kops create cluster --name=useast1.dev.example.com --state=s3://clusters.dev.example.com \
 --zones=us-east-1c --node-count=2 --node-size=t2.micro \
 --master-size=t2.micro --dns-zone=useast1.dev.example.com

#--------------------------------------Creating-K8s-Cluster[Multi-Zone]--------------------------------------------------------------#

kops create cluster --cloud=aws --zones=us-east-1a,us-east-1b --networking calico \
 --master-size t2.micro --master-count 3 --node-size t2.micro --node-count 3 \
 --name=pavanawsb28.xyz --dns-zone=pavanawsb28.xyz --dns public

#--------------------------------------Updating-K8s-Cluster-------------------------------------------------------------------------#

kops update cluster useast1.dev.example.com --yes --state=s3://clusters.dev.example.com

#--------------------------------------Updating-K8s-Cluster-------------------------------------------------------------------------#

kops update cluster pavanawsb28.xyz --yes --admin

#-------------------------------------Validating-Cluster----------------------------------------------------------------------------#

kops validate cluster
kubectl get nodes
kubectl cluster-info
kubectl api-resources
kubectl create -f testkube.yaml
kubelctl get pods
kubectl get pods -o wide
kubectl get pods,svc

#--------------------------------------Listing-The-Clusters-------------------------------------------------------------------------#

kops get cluster --state=s3://clusters.dev.example.com

#----------------------------------------Secrets------------------------------------------------------------------------------------#

kops get secret
kops delete secret SSHPublicKey admin 78:6a:e1:00:74:e6:ee:95:fa:32:fc:ae:2a:d7:63:68

#--------------------------------------Deleting-K8s-Cluster-------------------------------------------------------------------------#

kops delete cluster useast1.dev.example.com --yes --state=s3://clusters.dev.example.com
kops delete cluster pavanawsb28.xyz --yes

#------------------------Creating-Kubernetes-KOPS-Cluster-in-Existing-VPC------------------------------------------------------------#

'''
To create Kubernetes cluster in AWS using KOPS in Existing VPC

1.Export the s3 bucket to store kops states

export KOPS_STATE_STORE=s3://k8s.fosstechnix.info

2.Export the cluster name

export CLUSTER_NAME=k8s.fosstechnix.info

3.Export the existing AWS VPC

export VPC_ID=VPC_ID

4.Export the VPC CIDR range

export NETWORK_CIDR=172.20.0.0/16

5.Now create Kubernetes Kops cluster

kops create cluster --zones=ap-south-1a,ap-south-1b --name=${CLUSTER_NAME} --vpc=${VPC_ID}

6.To create a secret on Kubernetes KOPS cluster

kops create secret --name k8s.fosstechnix.info sshpublickey admin -i ~/.ssh/id_rsa.pub

7.Login to kops master node

ssh -i ~/.ssh/id_rsa ubuntu@api.k8s.fosstechnix.info

'''