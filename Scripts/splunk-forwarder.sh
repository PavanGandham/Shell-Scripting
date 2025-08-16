#!/bin/bash

set -o errexit
# This will delete the installation of splunk forwarder if there already is one installed. allows you to run script to reinstall
rm -rf /opt/splunkforwarder
# Edit this section to get the most recent up to date wget command for downloading splunk forwarder
sudo wget -O splunkforwarder-8.2.0-e053ef3c985f-Linux-x86_64.tgz \
https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.2.0&product=universalforwarder&filename=spl$
sudo tar xvzf splunkforwarder-8.2.0-e053ef3c985f-Linux-x86_64.tgz -C /opt
cd /opt/splunkforwarder/bin

# default username is admin
# generates random password for admin account
sudo ./splunk start --accept-license --no-prompt --gen-and-print-passwd
#enables start on boot
sudo ./splunk enable boot-start

#Adds the instance of where you are going to be forwarding your logs
cd /opt/splunkforwarder/etc/system/local
sudo touch outputs.conf
echo "" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "[tcpout]" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "defaultGroup = default-autolb-group" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "[tcpout:default-autolb-group" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "disabled = false" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "server = NAME_OF_YOUR_SPLUNK_SERVER:9997" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf
echo "[tcpout-server://NAME_OF_YOUR_SPLUNK_SERVER:9997]" | sudo tee -a /opt/splunkforwarder/etc/system/local/outputs.conf

#adds the monitoring of var/log/syslog (relatively important for monitoring linux (ubuntu) servers. optional however and can be configured from a deployment server)
sudo touch inputs.conf
echo "[monitor://var/log/syslog]" | sudo tee -a /opt/splunkforwarder/etc/system/local/inputs.conf
echo "disabled = 0" | sudo tee -a /opt/splunkforwarder/etc/system/local/inputs.conf

#adds the deployment server for managing the newly created instance (optional but defnitely should use a deployment server)
sudo touch deploymentclient.conf
echo "[deployment-client]" | sudo tee -a /opt/splunkforwarder/etc/system/local/deploymentclient.conf
echo "[target-broker:deploymentServer]" | sudo tee -a /opt/splunkforwarder/etc/system/local/deploymentclient.conf
echo "targetUri = NAME_OF_DEPLOYMENT_SERVER:8089" | sudo tee -a /opt/splunkforwarder/etc/system/local/deploymentclient.conf

#reboots splunk to save changes
cd /opt/splunkforwarder/bin
sudo ./splunk restart


# ---------------------------------------------------------------------------------------------------------------------------
#!/bin/bash

set -o errexit 



# User input. Comment out this section and replace with $serv and $depserv with hardcoded variables below if you choose to omit

# You also may need to change the port #'s if you chose to not use the splunk default ports in your environment



read -p "Please enter the name of Splunk server you will be forwarding your logs to: " serv

if ping -c 1 "$serv" &> /dev/null

then

    echo "Server Succesfully Reached"

else

    echo "Server cannot be reached"

    exit

fi



while true; do

    read -p "Do you have a Splunk Deployment Server? (y/n) " dep

    if [[ $dep = "y" ]]; then

        read -p "Enter deployment server name: " depserv

        if ping -c 1 "$depserv" &> /dev/null

        then

            echo "Server Succesfully Reached"

            break

        else

            echo "Server cannot be reached"

            exit

        fi



   elif [[ $dep = "n" ]]; then

        echo "User does not have a deployment server"

        break

   else

        echo "Please enter 'y' for yes or 'n' for no: "

   fi

done



# This will check for/delete the installation of splunk forwarder if there already is one installed. allows you to run script again to reinstall

FILE=/opt/splunkforwarder

if [ -d "$FILE" ]; then

    while true; do

    read -p "A version of Splunk is already installed. Do you wish the overwrite? (y/n) " over

        if [[ $over = "y" ]]; then

            sudo /opt/splunkforwarder/bin/splunk stop

            sudo rm -rf /opt/splunkforwarder

            break

        elif [[ $over = "n" ]]; then

            echo -e "\nUser chose to not overwrite existing version of Splunk\n"

            exit

        else

            echo "Please enter 'y' for yes or 'n' for no: "

        fi

    done

fi



# Edit this section to get the most recent up to date wget command for downloading splunk forwarder 
# Splunk version 9.0

temp_dir=$(mktemp -d)

cd $temp_dir

wget -O splunkforwarder-9.0.0-6818ac46f2ec-Linux-x86_64.tgz "https://download.splunk.com/products/universalforwarder/releases/9.0.0/linux/splunkforwarder-9.0.0-6818ac46f2ec-Linux-x86_64.tgz" &> /dev/null

if [[ "$?" != 0 ]]; then

        echo -e "Failed to download file. Exiting script.\n"

        rm -r $temp_dir

        exit

else

        echo -e "\nSplunk files successfuly downloaded\n"

fi

tar xvzf splunkforwarder-9.0.0-6818ac46f2ec-Linux-x86_64.tgz -C /opt

rm -r $temp_dir



# Default username is admin

# Generates random password for admin account. Random password can be found in script output if you wish to take note of it

cd /opt/splunkforwarder/bin

sudo ./splunk start --accept-license --no-prompt --gen-and-print-passwd

#sudo ./splunk enable boot-start seems to not be working here. splunk must be stopped for it to be enabled



#Adds the instance of where you are going to be forwarding your logs

cd /opt/splunkforwarder/etc/system/local

sudo touch outputs.conf

echo -e "Outputs.conf \n"

sudo tee -a outputs.conf << END 

[tcpout]

defaultGroup = default-autolb-group



[tcpout:default-autolb-group]

disabled = false

server = $serv:9997



[tcpout-server://$serv:9997]



END



# Adds the monitoring of var/log/syslog (relatively important for monitoring linux (ubuntu) servers)

# This is optional. The inputs you choose to monitor should be configured from a deployment server 

# Comment out if you choose it is not needed

sudo touch inputs.conf

echo -e "Inputs.conf \n"

echo "[monitor://var/log/syslog]" | sudo tee -a /opt/splunkforwarder/etc/system/local/inputs.conf

echo "disabled = 0" | sudo tee -a /opt/splunkforwarder/etc/system/local/inputs.conf



# Adds the deployment server for managing the newly created instance (optional but defnitely should use a deployment server)
if [[ $dep = "y" ]]; then

    sudo touch deploymentclient.conf

    echo -e "\nDeploymentclient.conf \n"

    sudo tee -a deploymentclient.conf << END

[deployment-client]

[target-broker:deploymentServer]

targetUri = $depserv:8089

END

fi



echo -e "\nEnd of file changes \n"



#reboots splunk to save changes

#sudo ./opt/splunkforwarder/bin/splunk stop

#sudo /opt/splunkforwarder/bin/splunk enable boot-start

#sudo ./opt/splunkforwarder/bin/splunk start

cd /opt/splunkforwarder/bin

sudo ./splunk restart