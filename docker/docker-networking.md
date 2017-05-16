---

# Docker Networking

This is a write up of my docker networking demo at the Docker Orlando meetup.

Let's begin with the diagram.

![figure-1](img/docker-networking.png)

We can see in *figure 1* a server which can be a physical device or a vm(cloud or not)
connect to the Internet by an interface *ens3* as its gateway interface - *ens3* 
because kvm configures it by default.
Then we have four Linux bridges. One is *docker0* which is the default linux bridge
configured when Docker is set up. It has connection the outside world, and it has 
inter-container communication enabled by default. Then we have two network segments managed by Docker 
which are *user-defined networks*. These bridges are also Linux bridges. One of these
bridges(*demo_internal*) is an internal network which means it doesn't have connection to the outside, and
the other one(*demo_net*) has connection to the outside world. Finally, there's 
*demo_ns* which is **only a network namespace** and NOT A VIRTUAL SERVER. This
segment has two virtual ethernet interfaces which their final end are connected 
to a Linux bridge *nsbr0*  and to the *server* respectively.


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
apt update && apt install docker-ce -y
systemctl stop docker
dockerd --icc=false &
docker network create -o "com.docker.network.kbridge.enable_icc=false" --internal demo_internal
docker network create demo_net
docker run -itd --name=c_in_bridge busybox
docker run -itd --name=c_in_internal --network=demo_internal busybox
docker run -itd --name=c_in_net --network=demo_net busybox
docker run -itd --name=web_in_all httpd:2.4
docker network connect bridge web_in_all
docker network connect demo_internal web_in_all
docker network connect demo_net web_in_all
