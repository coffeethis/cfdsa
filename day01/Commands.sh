exit 0
# This is summarized notes of what I learnt in day 1

# Create docker network
docker network create nw-net

# Create docker volume
docker volume create nw-vol

# Create db with local volume
docker run -d \
    --name nwdb --network nw-net \
    -v nw-vol:/var/lib/mysql \
    stackupiss/northwind-db:v1

# Create app within same network
docker run -d \
    --name nwapp --network nw-net \
    -e DB_HOST=nwdb \
    -e DB_USER=root \
    -e DB_PASSWORD=changeit \
    -p 8080:3000 \
    stackupiss/northwind-app:v1

# To run my own local python package and name it
docker run --rm -p 8080:3000 --name dov-bear-python ghcr.io/johantannh/dov-bear:v1python

# To exec into container and get shell
docker exec -it --rm <container_id> <shell_program_like_bash>

# Following the quick start https://github.com/sigstore/cosign#quick-start
# Step 1: Generate key pair
cosign generate-key-pair

# Step 2: Sign the image
cosign sign --key cosign.key ghcr.io/johantannh/dov-bear:v1python

# Step 3: verify before pulling
cosign verify --key cosign.pub ghcr.io/johantannh/dov-bear:v1python

---

# Workshop01 recap
# docker CLI -> dockerd -> containerd -> runc
# containers run in their own namespaces and isolation
# Default runtime is runc. Other types of secured runtime ( i.e. runsc) includes gVisor from google, kata-container used for sandboxing. runsc consumes more resources and longer to initiate.




docker build -t dov-bear:v1 . 
docker tag dov-bear:v1 \
ghcr.io/fred/dov:v1


docker images

#run in server mode
docker run -d -p HOST_port:internal_post image_name:v1

# Containers are empheral, volume is need to persist data 
# bind mode = EFS equivalent. Bind mount vol can be shared with multiple containers.
# volume = EBS equivalent

docker volume create <vol_name>

# Full path is need for bind mount vol
# docker run -v <vol path in host>:<container mount point>
docker run -v /opt/myvol:/opt/myvol

# For volume mount
bind run -v myvol:/opt/myvol

# For networking including network plugin. Docker swarm deprecated. Docker supports bridge and host networking.
# Bridge = NAT/Router  eg. Docker (172.xx.xx.xx/16)-> Bridge -> Local Host (192.xx.xx.xx)

# Host = Container directly attached to host.Cconsumes the same IP as host. Listen on container ports.
# By default, Docker creates two default nw. Bridge and Host. Default does not comes dafault with DNS.
# Only custom network will have DNS created.
# Network is commonly used for app segregation.


docker network ls
docker network create <my_network>

docker run -d --name <myaap> --network <mynet>

---

# create a network
docker network create nw-net

# create the volume
docker volume create nw-vol

# create the database container with the volume
docker run -d \ 
    --name nwdb --network nw-net \
    -v nw-col:/var/lib/mysql \
    stackupiss/northwind-db:v1

# run the web app in the same network
docker run -d 8080:3000 \
    --name nwapp --network nw-net \
    -e DB_HOST=nwdb \
    -e DB_USER=root \
    -e DB_PASSWORD=changeit \
    stackupiss/northwind-app:v1


# Other commands
docker run -d -p 3306:3306 \ 
-v nw-vol: /var/lib/mysql \
stackupiss/northwind-db:v1

docker rm -f $(docker ps -aq)

cd workshop01
ls
docker volume create nw-vol
docker run -d -p 3306:3306 -v nw-vol: /var/lib/mysql stackupiss/northwind-db:v1


docker network inspect

docker run -it --rm --network nw-work nicolaka/netshoot:v0.5 bash

nslookup dov-bear

docker ps 

docker vol rm nw-vol

# delete the volume
docker volume rm myvol

docker ps

nslookup nwdb
