#!/bin/bash

#Encrypt a Large File with OpenSSL in Linux

#Create Example Reference File
fallocate -l 1024M test.txt

#add some text to this file using the echo command.

echo "LinuxShellTips tutorial on encrypting a large file with OpenSSL in Linux" >> test.txt
cat test.txt

# Encrypt File with Password Using OpenSSL

Here, a single password or secret key will be used to encrypt our large text file. 
The symmetric-key encryption algorithm we will be referencing is AES (Advanced Encryption Standard).
This algorithm can accommodate 128, 192, and 256 bits cryptographic keys for data in 128 bits blocks to be successfully encrypted and decrypted.
