# creating RBAC for anand and bala
# 1. save the CA.crt and CA.key from the S3 bucket path pavank8s.ml/pki/private/ca/xxxxxxxxxxxxxx.key | 
# pavank8s.ml/pki/issued/ca/xxxxxxxxxxxxxx.crt

# 2. create anand.key and anand.csr using openssl

openssl genrsa -out anand.key 2048
openssl req -new -key anand.key -out anand.csr -subj "/CN=anand/O=development"

# 3. create a certificate using these csr and key 
openssl x509 -req -in anand.csr -CA CA.crt -CAkey CA.key -CAcreateserial -out anand.crt -days 45

# 4. similarly create for bala as bala.key , bala.csr
openssl genrsa -out bala.key 2048
openssl req -new -key bala.key -out anand.csr -subj "/CN=bala/O=production"

# 5. create a certificate using these csr and key 
openssl x509 -req -in bala.csr -CA CA.crt -CAkey CA.key -CAcreateserial -out bala.crt -days 45
