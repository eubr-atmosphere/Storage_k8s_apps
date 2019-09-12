# database with permissions
sudo kubectl exec -it vallum-db -- server/start.sh

# patient information database
sudo kubectl exec -it vallum-repo -- server/start.sh

# audit database
sudo kubectl exec -it vallum-audit-db -- server/start.sh

