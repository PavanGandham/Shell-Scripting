#!/bin/bash

has_sudo_access=""

$(timeout -k 2 2 bash -c "sudo /bin/chmod --help" >&/dev/null 2>&1) >/dev/null 2>&1
if [ $? -eq 0 ]; then
    has_sudo_access="YES"
else
    has_sudo_access="NO"
fi

echo "Does user $(id -Gn) has sudo access?: $has_sudo_access"

#--------------------------------------------------------------------------------------------------------#

#!/bin/bash
has_sudo_access=""
printf "mypassword\n" | sudo -S /bin/chmod --help >/dev/null 2>&1
if [ $? -eq 0 ]; then
    has_sudo_access="YES"
else
    has_sudo_access="NO"
fi

echo "Does user $(id -Gn) has sudo access?: $has_sudo_access"
