#!/bin/bash

# Installing kubectx and kubens for k8s cluster.

wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz
tar -xvzf kubectx_v0.9.4_linux_x86_64.tar.gz
mv kubectx /usr/local/bin/kubectx

wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz
tar -xvzf kubens_v0.9.4_linux_x86_64.tar.gz
mv kubens /usr/local/bin/kubens

# Autocomplete of commands
git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
ln -sf ~/.kubectx/completion/kubens.bash $COMPDIR/kubens
ln -sf ~/.kubectx/completion/kubectx.bash $COMPDIR/kubectx
cat << EOF >> ~/.bashrc

#kubectx and kubens
export PATH=~/.kubectx:\$PATH
EOF

# Setting colors for namespaces and contexts 
export KUBECTX_CURRENT_FGCOLOR=$(tput setaf 6) # blue text
export KUBECTX_CURRENT_BGCOLOR=$(tput setab 7) # white background