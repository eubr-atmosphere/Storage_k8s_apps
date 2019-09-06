# database with permissions
sudo kubectl exec -it vallum-db-0 -- server/start.sh

# patient information database
sudo kubectl exec -it vallum-repo-0 -- server/start.sh

# audit database
sudo kubectl exec -it vallum-audit-db-0 -- server/start.sh

