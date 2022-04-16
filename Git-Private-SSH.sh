#!/bin/bash
ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts
eval $(ssh-agent)
ssh-agent bash -c \
'ssh-add /home/ubuntu/.ssh/[privateKey]; git clone git@github.com:[account]/project.git'
#use ssh agent forwarding.
#On the host running Packer load a ssh key that have access to git repository ssh-add <path to private key>.
#Ensure that you have "ssh_disable_agent_forwarding": false (default) in your packer template. See Docs: Communicator.
#Now in your packer provisioning script you should be able to clone the repository over SSH with git clone git@<GitLab server>:<repo.git>

#-------------------------------------Github-CLi-Installation------------------------------------------------------------------------

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

#-------------------------------------Adding/Listing SSH Key to GitHub Account-----------------------------------------------

gh ssh-key add [<key-file>] [flags]

#Options
# -t, --title string Title for the new key
#Options inherited from parent commands
# --help Show help for command

gh ssh-key list [flags]

#Options inherited from parent commands
 # --help Show help for command

#------------------------------------SSH-Keys-Check/Generating/Adding/Testing------------------------------------

#*********************************Checking*************************************************************************
ls -al ~/.ssh
# Lists the files in your .ssh directory, if they exist
# Check the directory listing to see if you already have a public SSH key. By default, the filenames of the public keys are one of the following:
# id_rsa.pub
# id_ecdsa.pub
# id_ed25519.pub

#*********************************Generating*************************************************************************
# Paste the text below, substituting in your GitHub email address.
ssh-keygen -t ed25519 -C "your_email@example.com"
#Note: If you are using a legacy system that doesn't support the Ed25519 algorithm, use:
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
# This creates a new ssh key, using the provided email as a label.
# > Generating public/private ed25519 key pair.
# When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.
# > Enter a file in which to save the key (/home/you/.ssh/id_ed25519): [Press enter]
# At the prompt, type a secure passphrase. For more information, see "Working with SSH key passphrases."
# > Enter passphrase (empty for no passphrase): [Type a passphrase]
# > Enter same passphrase again: [Type passphrase again]
# Adding your SSH key to the ssh-agent
# Before adding a new SSH key to the ssh-agent to manage your keys, you should have checked for existing SSH keys and generated a new SSH key.
# Start the ssh-agent in the background.
eval "$(ssh-agent -s)"
# > Agent pid 59566
# Depending on your environment, you may need to use a different command. For example, you may need to use root access by running sudo -s -H before starting the ssh-agent, or you may need to use exec ssh-agent bash or exec ssh-agent zsh to run the ssh-agent.
# Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_ed25519 in the command with the name of your private key file.
ssh-add ~/.ssh/id_ed25519

#*********************************Adding-To-GitHub*************************************************************************
# 1.Copy the SSH public key
# 2.In the upper-right corner of any page, click your profile photo, then click Settings.
# 3.In the user settings sidebar, click SSH and GPG keys.
# 4.Click New SSH key or Add SSH key.
# 5.In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal Mac, you might call this key "Personal MacBook Air".
# 6.Paste your key into the "Key" field.
# Click Add SSH key.

#*********************************Testing-SSH-Connection*************************************************************************
ssh -T git@github.com
# Attempts to ssh to GitHub
# You may see a warning like this:
# > The authenticity of host 'github.com (IP ADDRESS)' can't be established.
# > RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
# > Are you sure you want to continue connecting (yes/no)?
# Verify that the fingerprint in the message you see matches GitHub's RSA public key fingerprint. If it does, then type yes:
# > Hi username! You've successfully authenticated, but GitHub does not
# > provide shell access.