# database with permissions
sudo kubectl exec vallum-db -- server/start.sh

# patient information database
sudo kubectl exec vallum-repo -- server/start.sh

# audit database
sudo kubectl exec vallum-audit-db -- server/start.sh

