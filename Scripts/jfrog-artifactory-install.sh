#!/bin/bash
set -xeu

# How To Install JFrog Artifactory on Ubuntu 20.04 LTS

# Prerequisites
# A server running Ubuntu 20.04.
# A valid domain name pointed with your server.
# A root password is configured on your server.

# Install JFrog Artifactory

# 1. First, install Gnupg2 package with the following command:
sudo apt-get install gnupg2 -y

# 2. Next, download and add the GPG key with the following command:
wget -qO - https://api.bintray.com/orgs/jfrog/keys/gpg/public.key | apt-key add -

# 3. Next, add the JFrog Artifactory repository with the following command:
echo "deb https://jfrog.bintray.com/artifactory-debs bionic main" | tee /etc/apt/sources.list.d/jfrog.list

# 4. Once the repository is added, update the repository and install JFrog Artifactory with the following command:
apt-get update -y
apt-get install jfrog-artifactory-oss -y

# 5. Once the installaton has been completed successfully,Next, start the Artifactory service and enable it to start at system reboot with the following command:
systemctl start artifactory
systemctl enable artifactory

# 6. Next, verify the status of Artifactory service using the following command:
systemctl status artifactory

# At this point, Artifactory is installed and listening on port 8082. You can now proceed to the next step.
# 7. Configure Nginx as a Reverse Proxy
# Next, you will need to configure Nginx as a reverse proxy for JFrog. First, install the Nginx webserver with the following command:
apt-get install nginx -y

# 8. After installing Nginx, create a new Nginx virtual host configuration file with the following command:
# nano /etc/nginx/sites-available/jfrog.conf

# 9.Add the following lines:
# upstream jfrog {
#   server 127.0.0.1:8082 weight=100 max_fails=5 fail_timeout=5;
# }

# server {
#   listen          80;
#   server_name     jfrog.linuxbuz.com;

#   location / {
#         proxy_set_header X-Forwarded-Host $host;
#         proxy_set_header X-Forwarded-Server $host;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_pass http://jfrog/;
#   }
# }


echo 'upstream jfrog {
  server 127.0.0.1:8082 weight=100 max_fails=5 fail_timeout=5;
}

server {
  listen          80;
  server_name     jfrog.linuxbuz.com;

  location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://jfrog/;
  }
}' >> /etc/nginx/sites-available/jfrog.conf
# Save and close the file then activate the Nginx virtual host with the following command:
ln -s /etc/nginx/sites-available/jfrog.conf /etc/nginx/sites-enabled/

# 10. Next, verify the Nginx for any syntax error with the following command:
nginx -t

# 11. Finally, restart the Nginx service to implement the changes:
systemctl restart nginx

# 12. At this point, Nginx is configured to serve JFrog site. You can now proceed to the next step.

# Secure JFrog with Let's Encrypt SSL

# 13. It is recommended to secure JFrog with Let's Encrypt SSL. First, add the Certbot repository with the following command:
apt-get install software-properties-common -y
add-apt-repository ppa:ahasenack/certbot-tlssni01-1875471

# 14. Next, update the repository and install the Certbot client with the following command:
apt-get update -y
apt-get install certbot python3-certbot-nginx -y

# 15. Once the Certbot client is installed, run the following command to download and install Let's Encrypt SSL for your website:
certbot --nginx -d jfrog.linuxbuz.com

# You will be asked to provide your valid email and accept the term of service as shown below:
# Saving debug log to /var/log/letsencrypt/letsencrypt.log
# Plugins selected: Authenticator nginx, Installer nginx
# Enter email address (used for urgent renewal and security notices) (Enter 'c' to
# cancel): hitjethva@gmail.com

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Please read the Terms of Service at
# https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
# agree in order to register with the ACME server at
# https://acme-v02.api.letsencrypt.org/directory
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# (A)gree/(C)ancel: A

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Would you be willing to share your email address with the Electronic Frontier
# Foundation, a founding partner of the Let's Encrypt project and the non-profit
# organization that develops Certbot? We'd like to send you email about our work
# encrypting the web, EFF news, campaigns, and ways to support digital freedom.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# (Y)es/(N)o: Y
# Obtaining a new certificate
# Performing the following challenges:
# http-01 challenge for jfrog.linuxbuz.com
# Waiting for verification...
# Cleaning up challenges
# Deploying Certificate to VirtualHost /etc/nginx/sites-enabled/jfrog.conf

# 16. Next, select whether or not to redirect HTTP traffic to HTTPS:
# Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 1: No redirect - Make no further changes to the webserver configuration.
# 2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
# new sites, or if you're confident your site works on HTTPS. You can undo this
# change by editing your web server's configuration.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2

# 17. Type 2 and hit enter to start the process. Once the certificate has been installed, you should see the following output:
# Redirecting all traffic on port 80 to ssl in /etc/nginx/sites-enabled/jfrog.conf

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Congratulations! You have successfully enabled https://jfrog.linuxbuz.com

# You should test your configuration at:
# https://www.ssllabs.com/ssltest/analyze.html?d=jfrog.linuxbuz.com
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# IMPORTANT NOTES:
#  - Congratulations! Your certificate and chain have been saved at:
#    /etc/letsencrypt/live/jfrog.linuxbuz.com/fullchain.pem
#    Your key file has been saved at:
#    /etc/letsencrypt/live/jfrog.linuxbuz.com/privkey.pem
#    Your cert will expire on 2020-09-07. To obtain a new or tweaked
#    version of this certificate in the future, simply run certbot again
#    with the "certonly" option. To non-interactively renew *all* of
#    your certificates, run "certbot renew"
#  - Your account credentials have been saved in your Certbot
#    configuration directory at /etc/letsencrypt. You should make a
#    secure backup of this folder now. This configuration directory will
#    also contain certificates and private keys obtained by Certbot so
#    making regular backups of this folder is ideal.
#  - If you like Certbot, please consider supporting our work by:

#    Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
#    Donating to EFF:                    https://eff.org/donate-le

#  - We were unable to subscribe you the EFF mailing list because your
#    e-mail address appears to be invalid. You can try again later by
#    visiting https://act.eff.org.

# 18. Access Artifactory Web UI
# Now, open your web browser and type the URL https://jfrog.linuxbuz.com.Provide the default username as a "admin" and password as a "password", and click on the Login button.

# Now, click on the Get Started button.
# Set the new admin password and click on the Next button. 
# Set your base URL and click on the Next button.
# Select your desired repository and click on the Next button.
# Now, click on the Finish button. You should see the Artifactory dashboard