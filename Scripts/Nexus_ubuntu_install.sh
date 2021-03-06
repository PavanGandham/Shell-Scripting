#!/bin/bash -xe

################################################################################################
#Script Name :Nexus_ubuntu_install.sh
#Description : Install the Nexus artifactory for storing the project artifacts and dependencies.
#Author :Pavan Gandham
#Email :pavangandham99@gmail.com
#License : GNU GPL-3
################################################################################################

OS_NAME="$(sudo cat /etc/os-release | grep -i pretty_name | cut -d = -f2)"
PRE_REQ="1.OpenJDK-8 2.Minimum-CPUs:4 3.User-sudo-privileges 4.Set-User-limits 5.Web-Browser 6.Firewall/Inbound-port:22,8081"
USER_NAME="nexus"
EXIST_USER="$(cat /etc/passwd | grep -i $USER_NAME | cut -d : -f1)"
JAVA_VERSION="$(cat version.txt | grep -i version | grep -Eo '[0-9]\.[0-9]+')"
MAX_CPU="4"
CPU_CORES="$(cat /proc/cpuinfo | grep -i "cpu cores" | cut -d : -f2)"

echo -e "Installing Sonatype Nexus artifactory in $OS_NAME\n"
sleep 1
read -ra arr <<<$PRE_REQ
echo -e "--------- Total Pre-requisites for Nexus Installation are : ${#arr[*]} ----------- \n"

for i in ${arr[@]}; do
    printf "$i\n"
done
# Verifying Java JDk is available or not
func_jdk() {
    echo -e "\n####### Step-1 : Checking if Java JDK version 1.8 is available or not #######\n"
    sudo java -version >version.txt 2>&1
    if [ $JAVA_VERSION == "1.8" ]; then
        echo -e "Java version $JAVA_VERSION is available\n"
    else
        sudo apt install openjdk-8-jre-headless -y
        echo -e "Java 8 is successfully installed"
        sudo java -version
    fi
}

# Verifying CPU is min 4 or not
func_cpu() {
    echo -e "\n####### Step-2 : Checking if Having CPUs = 4 available or not #######\n"
    if [ $CPU_CORES == "4" ]; then
        echo -e "\n Minimum CPU requirement is met\n"
    else
        echo -e "Minimum CPU requirement is not met , need $(expr $MAX_CPU - $CPU_CORES) more CPUs\n"
        printf "Hint : Select the instance type as t2/t3.medium or large in AWS"
    fi
}

# Verifying user had sudo previleges or not

func_sudo() {
    echo -e "Checking if user $USER_NAME exists or not.........\n"
    sleep 1
    if [ $EXIST_USER -eq "nexus" ]; then
        echo "$USER_NAME exists"
        echo -e "Checking if user $USER_NAME is having sudo access or not\n"
    else
        echo -e "No user named $USER_NAME in the users."
        printf "As security practice, not to run nexus service using root user,  
            So, Creating a new user $USER_NAME for running Nexus service\n"
        echo -e "Provide the Password and details for the new user(details is not mandatory)\n"
        sudo adduser $USER_NAME
    fi
}

# Setting up the New User Limits

func_ulimits() {
    if [ $EXIST_USER -eq $USER_NAME ]; then
        
    fi
}

for ((j = 0; j < ${#arr[@]}; j++)); do
    case ${arr[j]} in
    "1.OpenJDK-8")
        func_jdk
        ;;
    "2.Minimum-CPUs:4")
        func_cpu
        ;;
    "3.User-sudo-privileges")
        func_sudo
        ;;
    "4.Set-User-limits")
        func_ulimits
        ;;
    "5.Web-Browser")
        func_web
        ;;
    "6.Firewall/Inbound-port:22,8081")
        func_firewall
        ;;
    esac
done
