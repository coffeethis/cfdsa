exit 0
# This is summarized notes of what I learnt in day 2

# Create namespace "bggns"
kubectl create namespace bggns

# Apply DB deployment
kubectl apply -f db-deploy.yaml -nbggns       

# Check DB correctness
kubectl exec <pod_name> -nbggns -it bash
> mysql -u root -p

# base64 of password to write into Secret. IMPORTANT: use -n to extract away the new line
echo -n "changeit" | base64 

# Apply backend app deployment
kubectl apply -f backend-deploy.yaml

# Get ConfigMap, Secret and Pods,LB etc with more details to check states
kubectl get cm,secret,all -nbggns -owide

# Example of viewing logs in a specified pod
kubectl logs <pod_name> -nbggns

# Delete DB deployment
kubectl delete -f db-deploy.yaml -nbggns 

# Delete backend app deployment 
kubectl delete -f backend-deploy.yaml -nbggns
