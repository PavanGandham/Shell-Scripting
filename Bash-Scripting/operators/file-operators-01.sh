#!/bin/bash
terraformfile="~/terraform.sh"
read -p "Enter the Folder name You want to search for :" Folder
Path=$(find / -type d -name "$Folder") >>/dev/null 2>&1
if [ -z $Path ] >>/dev/null 2>&1; then
 echo "Invalid Input Folder/Directory Doesn't exist"
else
 cd $Path
 exec "$terraformfile"
fi

#--------------------------------------------------------------------------------
#!/bin/bash
printf "Recommended Terraform Versions....\n 14.0 to 14.11\n 15.0 to 15.3\n"
read -p "Enter the Terraform Major Version :" Major
read -p "Enter the Terraform Minor Version :" Minor
read -p "Enter the FolderName :" folder1
if [ $Major -lt 14 ]; then
 echo "Please Select Either of 14 or 15 Version !!!"
else
 Version=${Major}.${Minor}
 echo "Downloading Terraform version 0.$Version ........."
 if [ -d /tmp/$folder1 ]; then
 echo "Folder Already Exists ......"
 cd /tmp/$folder1
 if [ -f terraform_0.${Version}.zip ]; then
 echo "Version Already Exists"
 else
 rm -f terraform_0.*
 wget https://releases.hashicorp.com/terraform/0.${Version}/terraform_0.${Version}_linux_amd64.zip
 mv terraform_0.${Version}_linux_amd64.zip terraform_0.${Version}.zip
 fi
 unzip -o terraform_0.${Version}.zip 
 chmod 700 terraform
 ./terraform version
 else
 echo "Let's Create a Folder ....."
 mkdir /tmp/$folder1 && cd /tmp/$folder1
 wget https://releases.hashicorp.com/terraform/0.${Version}/terraform_0.${Version}_linux_amd64.zip
 mv terraform_0.${Version}_linux_amd64.zip terraform_0.${Version}.zip
 unzip -o terraform_0.${Version}.zip && chmod 700 terraform
 ./terraform version
 fi
fi