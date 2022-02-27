#!/bin/bash
# 1. Generate CA's private key and self-signed certificate

rm -rf *.pem *.srl
echo "............Cleaning the previous Certificates,keys etc..............."

openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C = IN/ST = AP/L = HYD/O = Gandham's Pvt Ltd/OU = Testing/CN = *.ec2-3-86-105-238.compute-1.amazonaws.com//emailAddress = pavangandham99@gmail.com"
echo ".................CA Self-Signed Certficate.................................... "

openssl x509 -in ca-cert.pem -noout -text   # displays the cert in a text format

# 2. Generate web server's private key and certificate signing request (CSR)

openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C = IN/ST = MH/L = MUM/O = Server's Pvt Ltd/OU = Development/CN = *.pavanaws99.xyz/emailAddress = server999@gmail.com"

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
echo "By Default the certificate validity is 30 days. Do you want to extend the validity ?..."
read -p "Enter Yes or No (Y/N) :" Choice

if [ $Choice == Y ]; then
 read -p "Enter No. of Days to Extend the Certificate Validity : " Days
 
 openssl x509 -req -in server-req.pem -days $Days -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem

 echo "..........................Validity extended upto $Days days...................................."

 openssl x509 -in server-cert.pem -noout -text #displays the cert in a text format

 openssl x509 -req -in server-req.pem -days $Days -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

openssl x509 -in server-cert.pem -noout -text
elif [ $Choice == N ]; then
 echo "...........................Validity Not extended remains with 30 days Validity................"

 openssl x509 -req -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem

else
 echo "Invalid Input!"
fi

# 4. Verifying the certificate is valid or not
openssl verify -CAfile ca-cert.pem server-cert.pem