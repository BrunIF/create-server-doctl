# Automate server creation on DigitalOcean

## Pre Install Server

### Generate token on DO
Before installation, you need generate *Token* **[API -> Tokens -> Generate New Token](https://cloud.digitalocean.com/settings/api/tokens)**. After run command:
```
doctl auth init
```
and paste your token

### Generate SSH key 

You need generate key in this folder, because it need to your future server. Run next command:
```
ssh-keygen -t rsa -b 4096 -C "autodeploy@yourcompany.com"
```
Now you must copy and paste your *id_rsa.pub* key on bitbucket.org (or github.com, gitlab.com,...)

## Install Server

Edit file *setup-server.sh* and change variables value DROPLET_NAME, USER_NAME, DOMAIN_NAME, SUB_DOMAIN_NAME. On end of file *userdata.sh* you must change repository URL. After if you do that run script
```
./setup-server.sh
```


Wait 5-10 minutes and your server will be ready to use.
