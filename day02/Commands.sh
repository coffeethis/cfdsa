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

---

# Workshop02 Intro
# K8S cluster will orchestrate the lifecycle of the containers including restart, nbr of container instances, scheduling.
# serverless K8S includes Knative.
# K8S = PaaS ( similar to Herouku, AWS Beanstalk)
# There are two types of nodes ( Master -> Worker nodes)

# Ways to deploy K8S
# Method 1 : Blog : Bootstrap K8S the hard way on google platform
# Method 2 : Using kubeadm - helps to automate and manage the TLS certs across master and worker nodes. AWS KUPS converts EC2 instances into K8S cluster.
# Method 3 : DigitalOcean will self manage the underlying
# Method 4 : Cluster API ( fairly new) is btw Method 1 & 2 which provides customisation. 


# K8S Control Plane ( Master )
# API server, scheduler, controller manager, etcd

# K8S Data Plane ( Worker )
# Containerd, kubelet and kubeproxy

# Interaction with K8S
# Dashboard, kubectl and programmatic REST API


# single minikube


echo "<cert>" | base64 -d 

openssl x509 -in ca.cert -noout -text | less

Go to home dir and create .kube

cd .kube

cp /Downloads/mycluster-kubeconfig.yaml config 

alias k="/usr/bin/kubectl"

k get ns

k get no -wide

k get pods -A


#Istio - Service mesh
# istio install envoy as a sidecar container to app containers in a multi-container pod. Envoy broker the traffic and establish ssl tunnel ( reverse proxy ).  

# Pod is lowest compute engine. 

# Various types of jobs that creates pods are : deployment , cronjob/job , daemonset ( eg. fluentd) and stateful set.

# to create the pod
kctl create -f pod-bear.yaml

# to inspect default namespace
kctl get po

# to proxy the port. Test with localhost on port 8080
kctl port-forward po/dov-bear 8080:3000

#
kctl describe po

# to define which namespace to deploy
kctl create -f pod-bear.yaml -n myns

# to 
kctl get po -nmyns -owide

# to get back on yaml file settings from etcd
kctl get no/dov-bear -nmyns -oyaml

# to force delete
kctl delete po/dov-bear -nmyns --force --grace-period=0
export now="--force --grace-period=0"

# apply changes if there are code changes.
kctl apply -f pod-bear.yaml -nmyns


kctl get cm/dov-bear-cm
kctl describe cm/dov-bear-cm

# to list secrets
kctl get secret

# default k8s service account
kctl describe secret/default-token-gxzfc


#scale up/down pods
kctl scale deploy/<name> --replicas=n -n <namespace>


kctl cluster info

kctl describe deploy 

# scale replica set

kctl scale rs/dov-bear-deploy-xxxxxx --replicas=2 -nmyns


kctl logs deploy/dov-bear-deploy-xxxxxx

kctl port-forward

kctl exec po/

# to troubleshoot connection
kctl run netshoot --image=nicolaka/netshoot:latest -ti --rm -- bash

#after bash login
# #nslookuo dov-bear-svc.myns.svc.cluster.local
# #curl dov-bear-svc.myns.svc.cluster.local:8080

# kctl get svc -owide 

# rollback with version
kctl get deploy/dov-bear-deploy -ndovns -oyaml | vim -c 'set ft=yaml'

# k8s has two networks. One is pod network and second is service network.
# kctl cluster-info 
# whenever pod is created, it adds an entry to kube-proxy and gets a IP from pod CIDR nw.

# setup HA for K8S cluster

# Ports in K8S
# ContainerPort, TargetPort, NodePort, ServicePort
# Service - ClusterIP, NodePort, LoadBalancer
