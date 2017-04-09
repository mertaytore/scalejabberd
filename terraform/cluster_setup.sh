#!/bin/bash

export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8

# Current node's ip is stored in temp_ip variable to be compared with cluster_ip
export temp_ip=$2
export temp_ip=`echo ip-$temp_ip | tr  '.'  '-'`

# Master node's ip is formatted and kept in ejabberd_cluster_ip, ready to be used
# for join operation
export cluster_ip=$1
export cluster_ip=`echo ip-$cluster_ip | tr  '.'  '-'`
export ejabberd_cluster_ip=`echo ejabberd@$cluster_ip | tr  '.'  '-'`

# joins the node to the cluster. won't do the join operation if the 'master' node
# (the node that has the cluster_ip) requests to join itself
if [ $cluster_ip != $temp_ip ]; then sudo /home/ubuntu/ejabberd-17.01/bin/ejabberdctl join_cluster $ejabberd_cluster_ip; else echo 'cannot join itself'; fi
