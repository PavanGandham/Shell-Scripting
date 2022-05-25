#!/bin/bash
RG=K8sB12
echo "---------Creating Azure Resource Group-------------------"

az group create --location eastus -n ${RG}

echo "---------Creating Azure Virtual Network------------------"

az network vnet create -g ${RG} -n ${RG}-Vnet-1 --address-prefix 10.1.0.0/16 \
--subnet-name ${RG}-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

read -p "Enter the no. of VMs to create : " VM
IMAGE=UbuntuLTS
echo "---------Creating Master Nodes -----------------------------------"
for i in {1..$VM}
do
az  vm create --resource-group ${RG} --name Master-0$i --image ${IMAGE} --vnet-name ${RG}-Vnet-1 \
--subnet ${RG}-Subnet-1 --admin-username adminpavan --admin-password "Pavan@123456" --size Standard_B2s \
--nsg "" --custom-data ./clouddrive/k8s.txt
done

echo "-----------Creating Worker Nodes-----------------------------------"
for i in {1..$VM}
do
az  vm create --resource-group ${RG} --name Worker-0$i --image ${IMAGE} --vnet-name ${RG}-Vnet-1 \
--subnet ${RG}-Subnet-1 --admin-username adminpavan --admin-password "Pavan@123456" --size Standard_B2s \
--nsg "" --custom-data ./clouddrive/k8s.txt
done


