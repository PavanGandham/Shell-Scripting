#-----------------------------------------Installing-Ansible-on-Ubuntu-----------------------------------------------------------------#
#!/bin/bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

#-----------------------------------------Installing-Ansible-on-RHEL-8-----------------------------------------------------------------#
# Step 1: Update RHEL 8
sudo dnf update -y
# Step 2: Install Python3 on RHEL 8
sudo dnf install python3
python3 -V
# Step 3: Install Ansible
subscription-manager repos --enable ansible-2.8-for-rhel-8-x86_64-rpms
sudo  dnf -y install ansible
ansible --version

# Ansible’s configuration file is ansible.cfg located at /etc/ansible/ansible.cfg.

# Step 4: Configure Passwordless SSH connection to the remote host
sudo systemctl status sshd
ssh-keygen -t rsa -b 4096

# The command generates an SSH key-pair i.e Private and Public key. 
# The private key resides on the Ansible control node while the public key is copied to the managed node. 
# To copy the public key to the managed node run the command:
ssh-copy-id james@192.168.43.103
# To continue, type Yes and provided the user’s login password.

# To verify that the Password less login was a success, try logging in using the syntax
ssh user@remote-IP address
# ssh james@192.168.43.103

# Step 5: Configure Ansible to communicate with Hosts
vim /etc/ansible/hosts
[webserver]
192.168.43.103

ansible -m ping webserver
ansible -m ping 192.168.43.103
ansible -m ping all



