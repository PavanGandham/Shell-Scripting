#---------------------------------------Prerequisites-for-installation---------------------------------------------

#Ref: https://www.ibm.com/docs/en/was-nd/8.5.5?topic=installation-preparing-ubuntu-204-operating-system

#--------------------------------------IBM-Installation-Manager------------------------------------------------------
#1. Download IM is based on your system configuration.I am using Linux now. IM software comes like

#Ref: https://www.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%7ERational&product=ibm/Rational/IBM+Installation+Manager&release=1.8.5.1&platform=Linux&function=fixId&fixids=1.8.5.1-IBMIM-LINUX-X86-20161016_1705&useReleaseAsTarget=true&includeRequisites=1&includeSupersedes=0&downloadMethod=http

wget https://ak-delivery04-mul.dhe.ibm.com/sdfdl/v2/sar/CM/RA/06i7v/0/Xa.2/Xb.jusyLTSp44S04x4c-oc-e9K-AGmXOHDLT6sG7sgAMywVTNFPg-cOJbwW4Y0/Xc.CM/RA/06i7v/0/agent.installer.linux.gtk.x86_1.8.5001.20161016_1705.zip/Xd./Xf.LPR.D1VC/Xg.11324609/Xi.habanero/XY.habanero/XZ.mKsbgjbXiG_Bpemdswkoq3nAKpQj6x2Z/agent.installer.linux.gtk.x86_1.8.5001.20161016_1705.zip

#2. Unzip the zip file.
unzip agent.installer.linux.gtk.x86_1.8.5001.20161016_1705.zip

#3. Go to "tools" directory under "IM root directory".

cd tools
#4. Run the "imcl" command by using syntax.
 
# Syntax: 
# imcl install package_id_version [,version][,featureId]
# -repositories source_repository
# -installationDirectory installation_directory
# -accessRights mode
# [ -preferences preference_key=value ]
# [ -dataLocation agent_data_location ]
# [ -keyring keyring_file -password keyring_password ]
# [ -acceptLicense ] 

./imcl install com.ibm.cic.agent -repositories \
/root/IM/repository.config -installationDirectory \
/opt/IBM/InstallationManager -acceptLicense -log \
/tmp/IM_install.log -showProgress

#O/P : Installed com.ibm.cic.agent_1.8.5001.20161016_1705 to the /opt/IBM/InstallationManager/eclipse directory.

#5. Now verify your box has IBM Installation Manager or not under /opt/IBM/InstallationManager directory



#-------------------------------------------WAS-Docker---------------------------------------------------------------------------------

#https://github.com/kavisuresh/ci.docker.websphere-traditional.git

docker run --name test -h test -v $(pwd)/PASSWORD:/tmp/PASSWORD \
 -p 9043:9043 -p 9443:9443 -d ibmcom/websphere-traditional:latest

docker run --rm -dit --name websphere_traditional --hostname websphere --volume $(pwd)/PASSWORD:/tmp/PASSWORD \
 --publish 9080:9080 --publish 9443:9443 ibmcom/websphere-traditional:latest

#Jenkins Destination for com.*jar files
/var/lib/jenkins/plugins/websphere-deployer/WEB-INF/lib

#WAS Source irectory for com.*jar files
/opt/IBM/WebSphere/AppServer/runtimes

#Copying the jar files into jenkins server using scp
scp com.ibm.ws.admin.client_8.5.0.jar root@10.40.1.141:/var/lib/jenkins/plugins/websphere-deployer/WEB-INF/lib
com.ibm.ws.admin.client_8.5.0.jar

scp com.ibm.ws.orb_8.5.0.jar root@10.40.1.141:/var/lib/jenkins/plugins/websphere-deployer/WEB-INF/lib
com.ibm.ws.orb_8.5.0.jar

#WAS_ND_8.5.5 Docker container
docker run --rm -dit --name was --hostname wsadmin --network was_network -p 28000:28000 -p 28001:28001 \
-v /tmp/websphere:/tmpfromhost amanly/websphere_8_5_5

#Expose ports
ports ->-p 9060:9060 -p 9080:9080 -p 9043:9043 -p 9443:9443 -p 8880:8880 

#Disable the Administration Security
vi /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells/cell01/security.xml
 -> enabled="false"
sed '/<enabled=.*/s/true/false/' test1.txt

/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/

/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/logs/dmgr/startServer.log

docker run --rm -dit --name was -h wsadmin --network was_network -v $(pwd)/Local:/tmp/Host \
 -p 9043:9043 -p 9443:9443 amanly/websphere_8_5_5

docker run --rm -dit --name was -h wsadmin --network was_network -p 28000:28000 -p 28001:28001 -v /tmp/websphere:/tmpfromhost amanly/websphere_8_5_5

./manageprofiles.sh -create -profileName Appsrv02 -profilePath /opt/IBM/WebSphere/AppServer/profiles/Appsrv02 -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/default/ -nodeName node02 -cellName cell02 -serverName server02 -hostName localhost

/opt/IBM/WebSphere/AppServer/profiles/Appsrv02/logs/AboutThisProfile.txt

iptables -t nat -A DOCKER -p tcp --dport 9060 -j DNAT --to-destination 172.18.0.2:9060
Docker IP Address check --> docker inspect --format '{{ .NetworkSettings.Networks.was_network.IPAddress }}' 7f6db4f3c177

docker run --rm -dit --name was --hostname wsadmin --network was_network -p 28000:28000 -p 28001:28001 -p 9060:9060 -p 9080:9080 -p 9043:9043 -p 9443:9443 -p 8880:8880 -v /tmp/websphere:/tmpfromhost amanly/websphere_8_5_5

./addNode.sh localhost 28003 -includeapps

docker run --rm -dit --name myjenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home --network was_network jenkins


#----------------------importing Websphere admin browser's SSL certificate--------------------------------------------------

keytool -import -trustcacerts -alias wasJenkinsCert -file $Cert_Path -keystore $JAVA_HOME/lib/security/cacerts

/usr/lib/jvm/java-11-openjdk-amd64/lib/security