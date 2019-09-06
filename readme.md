### HDFS and VALLUM application YAMLs

## HADOOP

The YAML creates a pod (hadoop-master) accessible on the address hadoop-master.default.svc.cluster.local and a replica set of three datanodes (hadoop-worker) accessible in the datanode-0.datanode.default.svc.cluster.local.

The YAML includes the creation of the volumes. When relaunching the cluster, we may found that the volumes have some undesirable data that prevents the datanode to properly join the cluster (e.g. the ID of a previous cluster), but as data may be valuable, we preferred to keep the volumes as persistent.

Create both sets of K8s objects on order:

kubectl create -f hadoop-master.yaml

kubectl create -f hadoop-worker.yaml
