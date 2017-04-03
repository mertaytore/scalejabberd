# Ejabberd server setup via Terraform & Packer
Spinning up EC2 instances utilizing Terraform with ejabberd 17.01 installed and running along with a cluster if the setup was made with multiple instances. Basically, automating the setup process for a faster maintenance.

## Setup steps
Packer creates an initial ami base to install ejabberd servers. Sample packer run:

```bash
packer validate create_image.json
packer build create_image.json
```

Terraform installs and forms a cluster of ejabberd servers. Needed parameters and a sample run:

-var admin_ejabberd : Your ejabberd server's admin username of your choice. <br>
-var pass_ejabberd : Your ejabberd server's admin password of your choice. <br>
-var instance_count : The number of nodes you'll have in your cluster. <br>
-var erlang_cookie : Erlang cookie functioning as a password between nodes. Preferably long and random. <br>
-var access_key : Your AWS access key. <br>
-var secret_key : Your AWS secret key. <br>
-var region : AWS region. <br>

```bash
terraform apply \
-var 'admin_ejabberd=YOUR_ADMIN_USERNAME' \
-var 'pass_ejabberd=YOUR_ADMIN_PASSWORD' \
-var 'instance_count=1' \
-var 'erlang_cookie=ERLANG_COOKIE_FOR_CLUSTERING' \
-var 'access_key=YOUR_AWS_ACCESS_KEY' \
-var 'secret_key=YOUR_AWS_SECRET_KEY' \
-var 'region=us-east-1'
```

After Terraform has finished, you can access your ejabberd's admin panel from your server's public ip's 5280 port: SERVER_PUBLIC_IP:5280/admin

