#!/usr/bin/env bash
#Certs standard (1 node, 1 cert)
host_name=$1
if [ "$host_name" == "" ]; then 
	echo "$0 <hostname>"
	exit 102
fi
keytool -help > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "keytool: command not found"
	exit 103
fi

if [ ! -f $PWD/CoreCA.pem ]; then
    echo "CoreCA.pem File not found!"
    exit 104
fi

DOMAIN=".example.com"
KS_PWD="YourSecretPasswd"
TS_PWD="changeit"

# Convert to pkcs12 format
openssl pkcs12 -export -in ${host_name}.crt -inkey ${host_name}.key -out ${host_name}.p12 \
	-chain -CAfile CoreCA.pem -name ${host_name}${DOMAIN} \
	-passin pass:${KS_PWD} -passout pass:${KS_PWD}

# Convert pkcs12 to jks
keytool -importkeystore -srcalias ${host_name}${DOMAIN} -destalias ${host_name}${DOMAIN} \
	-srckeystore ${host_name}.p12 -srcstoretype PKCS12 -srcstorepass ${KS_PWD} -srckeypass ${KS_PWD} \
	-destkeystore ${host_name}.jks -deststoretype JKS -deststorepass ${KS_PWD} -destkeypass ${KS_PWD}

# Set password to key
openssl rsa -aes256 -passout pass:${KS_PWD} -in ${host_name}.key -out ${host_name}-key.pem
