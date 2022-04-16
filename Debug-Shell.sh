# Debug shell script easily identify any errors Improvements Shell Script


'''$(While searching on Internet found very interesting and useful website which helps you, 
Debug shell script easily identify any errors Improvements in Shell script. 
Whatever the script you wrote, you can easily check with this tool.
Beginners write scripts but they don’t know really written in good format Or all parameters 
used correctly..? No need of worry improve your shell scripting skill set using this tool.

Advantages of ShellCheck
Verify the script line by line and get suggestion
Find errors in script
Improve your script like Pro
Get ride of syntax error’s
Handy / Simple tool
Either you can use this tool online www.shellcheck.net Or you can install directly on your 
Linux / Unix like system and use it.)
'''

# Debug shell script easily identify any errors in Linux
# Simply install using below commands on various distributions.

# Debian based distributions :

$ sudo apt-get install shellcheck

# Gentoo based distros :

$ emerge --ask shellcheck

# Fedora based distros :

$ dnf install ShellCheck

# OpenSUSE

$ zypper in ShellCheck

# Red Hat / Centos Distros :

yum install shellcheck

# Output from Ubuntu

'''pt-get install shellcheck

Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
 shellcheck
0 upgraded, 1 newly installed, 0 to remove and 169 not upgraded.
Need to get 1,603 kB of archives.
After this operation, 13.3 MB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu xenial/universe amd64 shellcheck amd64 0.3.7-5 [1,603 kB]
Fetched 1,603 kB in 0s (1,782 kB/s)
Selecting previously unselected package shellcheck.
(Reading database ... 60797 files and directories currently installed.)
Preparing to unpack .../shellcheck_0.3.7-5_amd64.deb ...
Unpacking shellcheck (0.3.7-5) ...
Processing triggers for man-db (2.7.5-1) ...
Setting up shellcheck (0.3.7-5) ...
Now we are ready to debug shell scripts from Linux using shellcheck command'''

shellcheck whichbig.sh

`In whichbig.sh line 14:
if test $a -gt $b
 ^-- SC2086: Double quote to prevent globbing and word splitting.
 ^-- SC2086: Double quote to prevent globbing and word splitting.
Note: ShellCheck will not check your logic. Which only check script errors and provide with improvements.
`