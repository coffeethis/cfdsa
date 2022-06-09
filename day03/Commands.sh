exit 0

# https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
# Install ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Check nginx template locally
helm template my-ingress ingress-nginx/ingress-nginx -n ingress-nginx > ingress.yaml

# Install ingress-nginx into cluster
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace

# Check what is running in cluster(after installing ingress-controller)
kubectl get all -n ingress-nginx

# Check what have I installed
helm repo list

# List what is installed
helm ls -a

# Uninstall an installed packaged item
helm uninstall ingress-nginx -n ingress-nginx

# Install Sealed secrets https://artifacthub.io/packages/helm/bitnami-labs/sealed-secrets
helm repo add bitnami-labs https://bitnami-labs.github.io/sealed-secrets/
helm repo update
helm install sealed-secrets bitnami-labs/sealed-secrets -n sealed-secrets --create-namespace

# Watch to see how the secrets are being created
watch kubectl get all,cm,secret -n sealed-secrets
# Worst case if anything happen, can just uninstall and reinstall again

# Applying kustomization on client to see whats different
kubectl apply -k . -oyaml --dry-run=client
# kubectl apply -k . -oyaml --dry-run=server

# To watch changes for a particular item in kubernetes
watch kubectl get all -nworkshop03

# Go to nip.io to get fake DNS for testing the ingress controller
# i.e. bgg-146.190.5.187.nip.io

# Install Ingress Controller so that IngressClass can work
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace

---
#workshop03 intro

#helm repo list
#helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace

#watch kctl get all -n ingress-nginx

#helm ls -A

#kctl get /secret/sealed-secrets-keyxxxx -n sealed-secrets -oyaml

# cat cert.crt | base64 -d 
#openssl x509 -in ss.cert -noout -text | less

# within the layer folder
#kctl apply -k . oyaml --dry-run=client

#traffic gen
#siege -c20 -v URL

---
# Get Storage Class
kubectl get sc

# https://artifacthub.io/packages/helm/metrics-server/metrics-server
# add the metrics-server to helm repo
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

# Install the metric-server chart
helm upgrade --install metrics-server metrics-server/metrics-server

# Node metrics
kubectl top node

# Pod metrics
kubectl top pod
