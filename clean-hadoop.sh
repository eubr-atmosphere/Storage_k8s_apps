sudo kubectl delete sts datanode 
sudo kubectl delete pod hadoop-master
sudo kubectl delete service datanode hadoop-master
sudo kubectl delete configmap hadoop-env
sudo kubectl delete pvc hdfs-datanode-0 hdfs-datanode-1 hdfs-datanode-2 
sudo kubectl delete pvc namenode-claim
sudo kubectl delete pv hdfs-pv-volume-0 hdfs-pv-volume-1 hdfs-pv-volume-2 hdfs-pv-volume-3

