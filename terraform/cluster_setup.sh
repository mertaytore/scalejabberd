echo 'locale setup start'
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8
echo 'locale setup done'

export temp_ip=$2
export temp_ip=`echo ip-$temp_ip | tr  '.'  '-'`

export cluster_ip=$1
export cluster_ip=`echo ip-$cluster_ip | tr  '.'  '-'`

export ejabberd_cluster_ip=`echo ejabberd@$cluster_ip | tr  '.'  '-'`

if [ $cluster_ip != $temp_ip ]; then sudo /home/ubuntu/ejabberd-17.01/bin/ejabberdctl join_cluster $ejabberd_cluster_ip; else echo 'cannot join itself'; fi
#sudo /home/ubuntu/ejabberd-17.01/bin/ejabberdctl list_cluster
