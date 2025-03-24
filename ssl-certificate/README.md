```shell
yum install -y socat && apt-get install -y socat # install socat
curl  https://get.acme.sh | sh
sudo ~/.acme.sh/acme.sh --set-default-ca  --server letsencrypt
sudo ~/.acme.sh/acme.sh --register-account -m network@echo.com

# SSL certificate installation path of the domain name examlpe.com /path

sudo ~/.acme.sh/acme.sh --issue -d example.com --standalone -k ec-256
sudo ~/.acme.sh/acme.sh --installcert -d example.com --fullchainpath /path/example.com.pem --keypath /path/example.com.key --ecc
```
