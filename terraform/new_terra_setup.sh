#!/bin/bash

export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8

# download and install
wget https://www.process-one.net/downloads/ejabberd/17.01/ejabberd-17.01-linux-x86_64-installer.run
sudo chmod +x ejabberd-17.01-linux-x86_64-installer.run
export temp_ip=$4
export temp_ip=`echo ip-$temp_ip | tr  '.'  '-'`
./ejabberd-17.01-linux-x86_64-installer.run --mode unattended --installdir /home/ubuntu/ejabberd-17.01 --hostname $temp_ip --admin $1 --adminpw $2 --cluster 1 --ejabberddomain $6

# .erlang.cookie setup
export cookie=$3
sudo chown root /home/ejabberd/
sudo chmod 660 /home/ejabberd/.erlang.cookie
sudo -u ejabberd sh -c "echo ${3} > /home/ejabberd/.erlang.cookie"
sudo chmod 400 /home/ejabberd/.erlang.cookie
sudo chown ejabberd /home/ejabberd/
sudo cat /home/ejabberd/.erlang.cookie

#echo 'Starting ejabberd server'
# setup done, starting the ejabberd server
sudo /home/ubuntu/ejabberd-17.01/bin/ejabberdctl start
export cluster_ip=$5
export cluster_ip=`echo ip-$cluster_ip | tr  '.'  '-'`
export ejabberd_cluster_ip=`echo ejabberd@$cluster_ip | tr  '.'  '-'`
