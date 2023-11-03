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
