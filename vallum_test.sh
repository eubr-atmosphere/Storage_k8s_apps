# Test
sudo kubectl create -f test_pod.yaml 
echo "## Enter values -> Server Mode: MN | MS (defines whether to use Vallum Monolithic or Microservice); "
echo "## Database: samples; "
echo "## User: user; "
echo "## Password: 123456; "
echo "## Query: select * from fake (there is only this table called 'fake'). "

sudo kubectl exec -it vallum-test -- server/test.sh



