#---------------------------------Without-Functions----------------------------------------------------------------------------------
#!/bin/bash
Regions=$@
for Region in $Regions; do
    if [ -z $Region ]; then
        echo "Invaild Input"
    else
        echo "---------------------------${Region}-------------------------------------------"
        VpcList=$(aws ec2 describe-vpcs --region $Region | jq ".Vpcs[].VpcId" | tr -d '"')
        echo -e "Printing the VPC List for region $Region :\n$VpcList\n"
        for Vpc in $VpcList; do
            SubnetIds=$(aws ec2 describe-subnets --region $Region --filters "Name=vpc-id,Values=$Vpc" | jq ".Subnets[].SubnetId")
            echo -e "Subnets for VPC-ID:${Vpc} in Region:${Region} are :\n${SubnetIds}\n"
        done
    fi
done

#------------------------------------With-Functions-[Type-1]--------------------------------------------------------------------------
#!/bin/bash
Regions=$@
func_main() {
    for Region in $Regions; do
        if [ -z $Region ]; then
            echo "Invaild Input...!!!"
        else
            echo "---------------------------------------------${Region}----------------------------------------------------------------"
            func_vpc "$Region"
        fi
    done
}
func_vpc() {
    Region=$1
    VpcList=$(aws ec2 describe-vpcs --region $Region | jq ".Vpcs[].VpcId" | tr -d '"')
    echo -e "Printing the VPC List for Region: $Region :\n$VpcList\n"
    func_subnet "${VpcList[@]}" "$Region"
    func_sg "${VpcList[@]}" "$Region"
}
func_subnet() {
    Region=$2
    for Vpc in $1; do
        SubnetIds=$(aws ec2 describe-subnets --region $Region --filters "Name=vpc-id,Values=$Vpc" | jq ".Subnets[].SubnetId")
        echo -e "Subnets for VPC-ID:${Vpc} in Region: ${Region} are :\n${SubnetIds}\n"
    done
}
func_sg() {
    Region=$2
    for Vpc in $1; do
        Security_groups=$(aws ec2 describe-security-groups --region $Region --filters "Name=vpc-id,Values=$Vpc" | jq ".SecurityGroups[].GroupId")
        echo -e "Security Groups for VPC-ID:${Vpc} in Region: ${Region} are :\n${Security_groups}\n"
    done
}

func_main

#--------------------------------------------------------With-Functions-[Type-2]-----------------------------------------------------------------------
#!/bin/bash
func_main() {
    for Region in $@; do
        echo "---------------------------------------------${Region}----------------------------------------------------------------"
        func_vpc
    done
}
func_vpc() {
    VpcList=$(aws ec2 describe-vpcs --region $Region | jq ".Vpcs[].VpcId" | tr -d '"')
    echo -e "Printing the VPC List for Region: $Region :\n$VpcList\n"
    for Vpc in $VpcList; do
        func_subnet 
        func_sg 
    done

}
func_subnet() {
    SubnetIds=$(aws ec2 describe-subnets --region $Region --filters "Name=vpc-id,Values=$Vpc" | jq ".Subnets[].SubnetId")
    echo -e "Subnets for VPC-ID:${Vpc} in Region: ${Region} are :\n${SubnetIds}\n"
}
func_sg() {
    Security_groups=$(aws ec2 describe-security-groups --region $Region --filters "Name=vpc-id,Values=$Vpc" | jq ".SecurityGroups[].GroupId")
    echo -e "Security Groups for VPC-ID:${Vpc} in Region: ${Region} are :\n${Security_groups}\n"
}
func_main $@