exit 0

# Update all helm repos
helm repo update

# https://github.com/bitpoke/mysql-operator
# Add to local helm repo
helm repo add bitpoke https://helm-charts.bitpoke.io

# Install helm chart
helm install mysql-operator bitpoke/mysql-operator -n myns --create-namespace
helm install mysql-operator bitpoke/mysql-operator -n mysql-operator --create-namespace

# Watch cluster in myns
watch kubectl get all,sts,pvc,mysqlcluster -n myns

# Get configMap in myns
k get cm -n myns

# Get secret in myns
k get secret -n myns

# 
k get svc -nmyns

# 
kubectl get pvc

# 
k get po -n myns -o wide

# 
k get crds

# 
k get mysqldatabase -A

# To get keyboard history
history

# 
sql > show databases;

# https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack

# To start and exec into pod
k run netshoot --image=nicolaka/netshoot -ti --rm -n myns -- bash

# To access an existing running pod
k exec po/mypod -ti -n myns -- bash

# To exec into pod by joining its namespace
k debug po/mypod --image=nicolaka/netshoot -ti --rm -n myns -- bash

# Create myns namespace
k create ns myns

# Delete 'stuck' namespaces
python3 -c "namespace='<my-namespace>';import atexit,subprocess,json,requests,sys;proxy_process = subprocess.Popen(['kubectl', 'proxy']);atexit.register(proxy_process.kill);p = subprocess.Popen(['kubectl', 'get', 'namespace', namespace, '-o', 'json'], stdout=subprocess.PIPE);p.wait();data = json.load(p.stdout);data['spec']['finalizers'] = [];requests.put('http://127.0.0.1:8001/api/v1/namespaces/{}/finalize'.format(namespace), json=data).raise_for_status()"

# 
kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller

---
#workshop4 
k get ns
k get all,sts, mysqlclusterpvc -n myns
kctl get ns
kctl get svc mysql-operator


nslookup mycluster-mysql-mysql-0.mysql.<namespace>

k get po -nmyns

k run netshoot --image=nikolaka/netshoot -ti --rm -- bash
bash5.1# nslookup

# existing pod
k exec po/mypod -ti -nmyns --bash

# to start and exec into pod. This create the container in a new pod
k run netshoot --image=nicolaka/netshoot -ti --rm -n<namespace> -- bash

# exec into a pod by joining into a namespace
k debug po/mypod --image=nikolaka/netshoot -ti -n<namespace> -- bash

nslookup mysql.myns



kctl create ns myns
kctl apply -f dov-bear.yaml

#BYD. pods in K8S can communicate to all other pods in all namespaces.
#BYD. K8S provides SVC and POD network.  
#K8S network policy by IP will need a network plugin.
# cilium in kube-system provides the 
# K8S network policy is whitelisting. 


kctl get netpol -nmyns

kctl describe netpol -nmyns

kctl delete -f dov-bear-netpol.yaml