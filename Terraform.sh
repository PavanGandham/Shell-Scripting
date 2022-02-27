#!/bin/bash
read -p "Enter the Terraform Version :" Version
echo "Downloading Terraform version $Version"
mv terraform terraform_old_$(date +%F)
wget https://releases.hashicorp.com/terraform/${Version}/terraform_${Version}_linux_amd64.zip
unzip terraform_${Version}_linux_amd64.zip
rm -f terraform_${Version}_linux_amd64.zip
chmod 777 terraform
./terraform version

#-------------------------------------------------------------------------------------------
#!/bin/bash
read -p "Enter the Terraform Major Version:" Major
read -p "Enter the Terraform Minor Version:" Minor
if [ $Major -lt 14 ]; then
 echo "Please Select Either of 14 or 15 Version !!!"
else
 Version=${Major}.${Minor}
 echo "Downloading Terraform version 0.$Version"
 rm -f terraform
 wget https://releases.hashicorp.com/terraform/0.${Version}/terraform_0.${Version}_linux_amd64.zip
 unzip terraform_0.${Version}_linux_amd64.zip
 rm -f terraform_0.${Version}_linux_amd64.zip
 chmod 777 terraform
 ./terraform version
fi

#--------------------------------------------------------------------------------------------------
#!/bin/bash
read -p "Enter the Terraform Major Version :" Major
read -p "Enter the Terraform Minor Version :" Minor
if [ $Major == 14 ]; then
 echo "Let's Download terraform 14 version"
elif [ $Major == 15 ]; then
 echo "Let's Download terrform 15 version"
elif [ $Major -lt 14 ]; then
 echo "Any version below 14 is invalid"
else
 echo "INVALID INPUT"
fi

#-----------------------------------------------------------------------------------------------------
#!/bin/bash
read -p "Enter the Terraform Major Version :" Major
read -p "Enter the Terraform Minor Version :" Minor
if [ $Major -ge 14 -a $Major -le 15 ] # if [ ! $Major -ge 14 -o $Major -le 15 ] 
then
echo "Let's Download $Major version"
else
echo "INVALID INPUT"
fi