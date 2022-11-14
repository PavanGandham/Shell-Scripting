#!/bin/bash

# How to Setup Postfix Mail Server and Dovecot with Database (MariaDB) Securely – Part 1

# I.) Create A and MX Records for Domain in DNS
# 1. You will need a valid domain registered through a domain registrar. 
# In this series we will use www.linuxnewz.com, which was registered through GoDaddy.
# 2. Such domain must be pointed to the external IP of your VPS or cloud hosting provider. 
# If you are self-hosting your mail server, you can use the service offered by FreeDNS (requires registration).

# In any event, you have to set up A and MX records for your domain as well
# Once added, you can look them up using an online tool such as MxToolbox or ViewDNS to ensure they are properly set up.

# 3. Configure the FQDN (Fully Qualified Domain Name) of your VPS:
hostnamectl set-hostname <yourhostname>

# to set the system hostname, then edit /etc/hosts as follows 
# (replace AAA.BBB.CCC.DDD, yourhostname, and yourdomain with the public IP of your server, your hostname, and your registered domain):
AAA.BBB.CCC.DDD yourhostname.yourdomain.com       <yourhostname>

# II.) Installing Required Software Packages
# 4. To install required software packages such as Apache, Postfix, Dovecot, MariaDB, PhpMyAdmin, SpamAssassin, ClamAV, etc, 
# you need to enable the EPEL repository:
yum install epel-release

# 5. Once you have followed the above steps, install the necessary packages:
# In CentOS based Systems:
yum update && yum install httpd httpd-devel postfix dovecot dovecot-mysql spamassassin clamav clamav-scanner clamav-scanner-systemd clamav-data clamav-update mariadb mariadb-server php phpMyAdmin
# In Debian and derivatives:
aptitude update && aptitude install apache2 postfix dovecot-core dovecot-imapd dovecot-pop

# 6. Start and enable the web and database servers:
# In CentOS based Systems:
systemctl enable httpd mariadb
systemctl start httpd mariadb
# In Debian and derivatives:
systemctl enable apache2 mariadb
systemctl start apache2 mariadb
# When the installation is complete and the above service are enabled and running, 
# we will start off by setting up the database and tables to store information about Postfix mail accounts.

# III.) Creating Postfix Mail Accounts Database
# For simplicity, we will use phpMyAdmin, a tool intended to handle the administration of MySQL / MariaDB databases through a web interface, 
# to create and manage the email database.

# However, in order to log on to and use this tool, we need to follow these steps:

# 7. Enable the MariaDB account (you can do this by running the mysql_secure_installation utility from the command line, 
# assigning a password for user root, and setting the default settings proposed by the tool EXCEPT “Disallow root login remotely?“:

# or otherwise create a new database user:
mysql -u root -p

MariaDB [(none)]> CREATE USER 'dba'@'localhost' IDENTIFIED BY 'YourPasswordHere';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON * . * TO 'dba'@'localhost';
MariaDB [(none)]> FLUSH PRIVILEGES;

# IV.) Secure Apache with a Certificate
# 8. Since we will be using a web application to manage the email server database, 
# we need to take the necessary precautions to protect connections to the server. 
# Otherwise, our phpMyAdmin credentials will travel in plain text over the wire.





