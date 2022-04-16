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
echo -e "Installing Sonatype Nexus artifactory in $OS_NAME\n"
sleep 1
read -ra arr <<<$PRE_REQ
echo -e "--------- Total Pre-requisites for Nexus Installation are : ${#arr[*]} ----------- \n"

for i in ${arr[@]}; do
    printf "$i\n"
done
# Verifying Java JDk is available or not
func_jdk () {
    echo -e "\n####### Step-1 : Checking if Java JDK version 1.8 is available or not #######\n"
    java -version >version.txt 2>&1
    JAVA_VERSION="$(cat version.txt | grep -i version | grep -Eo '[0-9]\.[0-9]+')"
    if [ $JAVA_VERSION == "1.8" ]; then
        echo -e "Java version $JAVA_VERSION is available\n"
    else
    sudo apt install openjdk-8-jre-headless -y
    fi
}

# Verifying CPU is min 4 or not

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

