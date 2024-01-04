# SAN

Script for generating certificate requests with subject alternative name(s) for a given RSA key.

1. Generate private key (if you don't have)
```
openssl genrsa -out server01.key 2048
```

2. Generate csr
```
./san --key=server01.key --csr=server01.csr --san="DNS.1:server01.example.com,IP.1:10.10.10.10" --dn="C=ID,ST=DKI,L=Jakarta,O=Example Inc,OU=IT,CN=server01.example.com"
```

3. Check csr. You will have these entries on your csr file:
```
$ openssl req -in server01.csr -noout -text
        Attributes:
        Requested Extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            X509v3 Key Usage:
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Subject Alternative Name:
                DNS:server01.example.com
                IP:10.10.10.10
```

4. [Optional] You can also convert cert from PEM format to JKS format with these command:
```
$ ./pem2jks.sh server01
```
