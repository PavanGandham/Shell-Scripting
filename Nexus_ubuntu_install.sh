#!/bin/bash -xe

################################################################################################
#Script Name :Nexus_ubuntu_install.sh
#Description : Install the Nexus artifactory for storing the project artifacts and dependencies.
#Author :Pavan Gandham
#Email :pavangandham99@gmail.com
#License : GNU GPL-3
################################################################################################

OS_NAME="$(cat /etc/os-release | grep -i pretty_name | cut -d = -f2)"
PRE_REQ=("Open JDK 8",
"Minimum CPUs: 4",
"Ubuntu Server with User sudo privileges.",
"Set User limits"
"Web Browser"
"Firewall/Inbound port: 22, 8081")

echo "Installing Sonatype Nexus artifactory in $(OS_NAME)"

echo "---------Pre-requisites for Nexus Installation-----------"

echo -e ""

