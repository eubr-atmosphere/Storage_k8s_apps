### HDFS and VALLUM application YAMLs

## HADOOP

The YAML creates a pod (hadoop-master) accessible on the address hadoop-master.*namespacename*.svc.cluster.local and a replica set of three datanodes (hadoop-worker) accessible in the datanode-0.datanode.*namespacename*.svc.cluster.local.

The YAML includes the creation of the volumes. When relaunching the cluster, we may found that the volumes have some undesirable data that prevents the datanode to properly join the cluster (e.g. the ID of a previous cluster), but as data may be valuable, we preferred to keep the volumes as persistent.

Create both sets of K8s objects on order:
```
kubectl create -f hadoop-master.yaml

kubectl create -f hadoop-worker.yaml
```

You can easily check the system 

```
ubuntu@kubeserver:~$ sudo kubectl exec -it hadoop-master -- hdfs dfsadmin -report
WARNING: HADOOP_PREFIX has been replaced by HADOOP_HOME. Using value of HADOOP_PREFIX.
Configured Capacity: 59837042688 (55.73 GB)
Present Capacity: 25703628800 (23.94 GB)
DFS Remaining: 22450724864 (20.91 GB)
DFS Used: 3252903936 (3.03 GB)
DFS Used%: 12.66%
Replicated Blocks:
	Under replicated blocks: 0
	Blocks with corrupt replicas: 0
	Missing blocks: 0
	Missing blocks (with replication factor 1): 0
	Pending deletion blocks: 0
Erasure Coded Block Groups: 
	Low redundancy block groups: 0
	Block groups with corrupt internal blocks: 0
	Missing block groups: 0
	Pending deletion blocks: 0

-------------------------------------------------
Live datanodes (3):

Name: 10.243.1.105:9866 (datanode-0.datanode.default.svc.cluster.local)
Hostname: datanode-0.datanode.default.svc.cluster.local
Decommission Status : Normal
Configured Capacity: 19945680896 (18.58 GB)
DFS Used: 1084301312 (1.01 GB)
Non DFS Used: 11587362816 (10.79 GB)
DFS Remaining: 6237237248 (5.81 GB)
DFS Used%: 5.44%
DFS Remaining%: 31.27%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Tue Sep 10 13:52:18 UTC 2019
Last Block Report: Tue Sep 10 10:06:38 UTC 2019
Num of Blocks: 2314


Name: 10.243.2.114:9866 (datanode-1.datanode.default.svc.cluster.local)
Hostname: datanode-1.datanode.default.svc.cluster.local
Decommission Status : Normal
Configured Capacity: 19945680896 (18.58 GB)
DFS Used: 1084301312 (1.01 GB)
Non DFS Used: 9967276032 (9.28 GB)
DFS Remaining: 7857324032 (7.32 GB)
DFS Used%: 5.44%
DFS Remaining%: 39.39%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Tue Sep 10 13:52:20 UTC 2019
Last Block Report: Tue Sep 10 10:01:19 UTC 2019
Num of Blocks: 2314


Name: 10.243.4.87:9866 (datanode-2.datanode.default.svc.cluster.local)
Hostname: datanode-2.datanode.default.svc.cluster.local
Decommission Status : Normal
Configured Capacity: 19945680896 (18.58 GB)
DFS Used: 1084301312 (1.01 GB)
Non DFS Used: 9468436480 (8.82 GB)
DFS Remaining: 8356163584 (7.78 GB)
DFS Used%: 5.44%
DFS Remaining%: 41.89%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Tue Sep 10 13:52:19 UTC 2019
Last Block Report: Tue Sep 10 12:11:06 UTC 2019
Num of Blocks: 2314
```


## VALLUM

This version of vallum expects to find the following endpoints:

- vallum (9000)           
- vallum-audit (9004)
- vallum-audit-db (3306)
- vallum-db (3306)
- vallum-privacy (9002)
- vallum-repo (3306)

So services are created for those pods so they can be accessed through the plain DNS name. The ports are indicated into brackets. Aditionally, Vallum expects an HDFS storage accessible in hadoop-master:8020.

The deployment is performed through the command:

``` 
kubectl create -f vallum.yaml
```

Services can be populated by executing the ```start.sh``` command in the ```/server``` directory of the following services:
- vallum-db
- vallum-repo
- vallum-audit-db

And copying the reference data in the home directory of the HDFS filesystem (not available in the public repository).

The testing example is available in the vallum-test container:

```
kubectl create -f test_pod.yaml

kubectl exec -it vallum-test -- java -jar /server/Test.jar samples MS user 123456 'select * from fake where id>=4208 limit 2'

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.6.RELEASE)

Starting...
{
  "result": [
    {
      "id": "4208",
      "team": "20213",
      "provar_id": "*",
      "diagnosis": "Normal",
      "study_date": "30/11/16",
      "study_time": "15:15:37",
      "sex": "M",
      "given_name": "*",
      "surname": "*",
      "city": "Minas Gerais",
      "birthday": "*",
      "files": [
        {
          "uri": "https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151859.MP4"
        },
        {
          "uri": "https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151840.MP4"
        },
        {
          "uri": "https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151816.MP4"
        },
        {
          "uri": "https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151911.MP4"
        }
      ]
    },
    {
      "id": "4209",
      "team": "20213",
      "provar_id": "*",
      "diagnosis": "Normal",
      "study_date": "30/11/16",
      "study_time": "15:32:16",
      "sex": "M",
      "given_name": "*",
      "surname": "*",
      "city": "Minas Gerais",
      "birthday": "*",
      "files": []
    }
  ],
  "total": 2
}
File Download: https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151859.MP4
File Download: https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151840.MP4
File Download: https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151816.MP4
File Download: https://vallum:9000/vallum/downloadFile/VH020213M4_003779_20161130T151911.MP4
Finish!

```
