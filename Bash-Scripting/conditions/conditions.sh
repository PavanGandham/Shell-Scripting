#----------------------------------[if-elif-else-if]--------------------------------------------------------
#!/bin/bash
echo "Presently Vaccines are Available for Above 45+ Years and Below 90 years Only"
Current_year=2021
read -p "Please Enter Your Year of Birth(YOB) :" YOB
Age=$(expr $Current_year - $YOB)
if [ $Age -le 18 ]; then
 echo "Vaccination is not Approved to Your Age at Present by Government....!!!"
elif [[ $Age -ge 19 && $Age -lt 45 ]]; then
 echo "Vaccination is Open for Your Age . Please Do Register in Cowin website.!!!"
elif [[ $Age -ge 90 && $Age -le 100 ]]; then
 echo "Vaccination is not a Suggested thing for you at this age. Please take care of your health!!!"
elif [[ $Age -ge 45 && $Age -lt 90 ]]; then
 echo "Presently Vaccines are Available for your Age. Please Do Visit the Nearby PHC and Get vaccinated as soon as possible...!!!"
else
 echo "INVALID AGE"
fi

#--------------------------------------[case-esac]---------------------------------------------------------
#!/bin/bash
read -p "Enter the Any AWS Region :" Region
Resources=(VPC S3 EC2 IAM Subnets)
echo "Resources in $Region"
for ((i = 0; i < ${#Resources[@]}; i++)); do
 printf "${Resources[$i]} \n"
done
read -p "Choose any one for Detailed Info:" Info
case "$Info" in
"VPC")
 echo "$(aws ec2 describe-vpcs --region $Region | jq ".Vpcs[].VpcId")"
 ;;
"S3")
 echo "$(aws s3 ls)"
 ;;
"EC2")
 echo "$(aws ec2 describe-instances --region $Region | jq ".Reservations[].Instances[].InstanceId")"
 ;;
"IAM")
 echo "$(aws iam list-roles --region $Region | jq ".Roles[].RoleId")"
 ;;
"Subnets")
 echo "$(aws ec2 describe-subnets --region $Region | jq ".Subnets[].SubnetId")"
 ;;
*)
 echo "Invalid Resource Name. Choose According to the given list!!!!"
 ;;
esac