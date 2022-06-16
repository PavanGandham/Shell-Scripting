#How to Send alerts to mail inbox from your Linux Server
There will be times when we want to send out some data, stats or resource alerts to our email from Linux host.
In this tutorial I am going to show how to setup emails to get notified when your machines want some tender love and attention.

#Step 1: Install Postfix and Simple Authentication and Security Layer (SASL) packages

apt-get install libsasl2-modules postfix

#There will be prompts asking General type of mail configuration. Select Internet Site:
# Enter the fully qualified name of your domain.
# example: kmaster-rj.example.com.

#Step 2: Update Postfix main.cf file
# After the installation completion, ensure that the myhostname parameter is configured with your server’s FQDN:

root@kmaster-rj:/etc/postfix/sasl# cat /etc/postfix/main.cf | grep ^myhostname
myhostname = kmaster-rj.example.com

# Step 3: Generate an Google App Password for Postfix
# When Two-Factor Authentication (2FA) is enabled, Gmail is preconfigured to refuse connections from applications like Postfix that don’t provide the second step of authentication.
# While this is an important security measure that is designed to restrict unauthorized users from accessing your account, it hinders sending mail through some SMTP clients as you’re doing here. Follow these steps to configure Gmail to create a Postfix-specific password:
# Log in to your email, then click the following link: Manage your account access and security settings. Scroll down to “Password & sign-in method” and click 2-Step Verification. You may be asked for your password and a verification code before continuing. Ensure that 2-Step Verification is enabled.
# Click the following link to Generate an App password for Postfix:

# Click Select app and choose Other (custom name) from the dropdown. Enter “Postfix” and click Generate.
# The newly generated password will appear. Write it down or save it somewhere secure that you’ll be able to find easily in the next steps, then click Done:
# You can verify the presence of password we generated just now

# Step 4: Add Gmail Username and App Password to Postfix configuration
# Usernames and passwords are stored in sasl_passwd in the /etc/postfix/sasl/ directory.
# Now you will have to add your email login credentials to this file and to Postfix.
# Create /etc/postfix/sasl/sasl_passwd file if not exist by default and add your gmail ID and password we

root@kmaster-rj:/etc/postfix/sasl# cat /etc/postfix/sasl/sasl_passwd
[smtp.gmail.com]:587 youremailaddress@gmail.com:kkegfdgdfgfdeaue
root@kmaster-rj:/etc/postfix/sasl#

# Note: The SMTP server smtp.gmail.com supports message submission over port 587 (StartTLS) and port 465 (SSL). Whichever protocol you choose, be sure the port number is the same in /etc/postfix/sasl/sasl_passwd and /etc/postfix/main.cf files.
# create the hash file for Postfix using the postmap command

root@kmaster-rj:~# postmap /etc/postfix/sasl/sasl_passwd

# If the above command is executed successfully, then you should have a new file named sasl_passwd.db in the /etc/postfix/.
root@kmaster-rj:/etc/postfix/sasl# ls
sasl_passwd sasl_passwd.db

# Step 5: Secure Your Postfix Hash Database and Email Password Files
# Since sasl_passwd consists of username and password in plain text, so it is recommended to change the file permission to root. This is to esnure that only the root user is able to read and edit the credentials in this file.

root@kmaster-rj:/etc/postfix/sasl# chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
root@kmaster-rj:/etc/postfix/sasl# chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db

# Step 6: Configure Relay Host
# Modify the main.cf file and set the relayhost entry to external SMTP server address as below.
# Note: if you have specified port no in sasl_passwd i.e. 587 as in the above example, then we need to specify in the same in the main.cf file also.

root@kmaster-rj:~# cat /etc/postfix/main.cf | grep -i ^relayhost
relayhost = [smtp.gmail.com]:587
root@kmaster-rj:~#

# Step 7: Add Custom Configuration At The End Of File

root@kmaster-rj:~# cat /etc/postfix/main.cf | tail -n 10

# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
#Save your changes and close the file.

# Step 8: restart postfix service

root@kmaster-rj:/etc/postfix/sasl# systemctl restart postfix

# Step 9: Testing Postfix
# Lets test whether our SMTP server can send emails to an external gmail account using sendmail command. Postfix logs can help as well.

root@kmaster-rj:/etc/postfix/sasl# sendmail youremailaddress@gmail.com
From: root@kmaster-rj.example.com
Subject: Test mail
This is a test email
.

# Change body and subject line accordingly and in place of email address use valid email id.

# Step 10: Send CPU alerts
# Lets send some interesting CPU usage data to our email address.
# It will trigger an email when your system reaches 4% CPU utilization.
# Its very less threshhold btw :) just to show you the usage I’ve taken this. You can do a stress test to increase the load average.
root@kmaster-rj:~# cat /proc/loadavg | awk '{print $1}' | awk '{ if($1 > 4) printf("Current CPU Utilization is: %.2f%\n"), $0;}' | mail -s "Alert! High CPU usage alert from Kubernetes Master" youremailaddress@gmail.com

# Note: Please change the email id and CPU utilization threshold value (which is 4 here) as per your requirement.
# Verify on your email inbox (don’t forget to check in spam folder if not found in primary mailbox)

# Note: You can configure the SMTP with different providers as well for e.g mandrill , sendgrid etc. You just need to update the sasl password. Everything else will remain same.
# Troubleshooting

# How to fix postfix/smtp Network unreachable error:
# When trying to send email to a gmail account through postfix you can see an error like this in the postfix logs /var/log/maillog :

Sep 28 17:49:54 solver postfix/smtp[10045]: connect to gmail-smtp-in.l.google.com[2a00:1450:400c:c05::1b]:25: Network is unreachable

# Solution for IPv4
# If you want to use IPv4 instead, then you should edit the Postfix configuration file and change inet_protocols = all to inet_protocols = ipv4 and restart or reload Postfix:

root@kmaster-rj:~# cat /etc/postfix/main.cf | grep -i ^inet_protocols
inet_protocols = ipv4
root@kmaster-rj:~# /etc/init.d/postfix reload

# and flush the Postfix queue or just wait and mail will start to send.:
root@kmaster-rj:~# postfix flush

# Mail queue operations
# To see mail queue, enter:
mailq

# To remove all mail from the queue, enter:
postsuper -d ALL

# To remove all mails in the deferred queue, enter:
postsuper -d ALL deferred

# Sending Mail

# 1. Send Full Mail using the following command:
mail -s "Hello World" youremailaddress@gmail.com

# OR you can also send mail to multiple recipients:
mail -s "Hello World" youremailaddress@gmail.com,youremailaddress@yahoo.com

# it asks for cc: and mail body
mail -s "Hello World" youremailaddress@gmail.com 
 Cc: youremailaddress@yahoo.com 
 Hi Test user
 How are you 
 This is Test Mail 
 <Ctrl+D>
# Press Ctrl+D for send mail

# 2. Mail in a Single Line
mail -s "subject" youremailaddressl@gmail.com <<< 'mail body'