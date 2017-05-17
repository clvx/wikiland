---

# Docker Networking

This is a write up of my docker networking demo at the Docker Orlando meetup.

Let's begin with the diagram.

![figure-1](img/docker-networking.png)

We can see in *figure 1* a server which can be a physical device or a vm(cloud or not)
connected to the Internet by an interface *ens3* as its gateway interface - *ens3* 
because kvm configures it by default.
Then we have four Linux bridges. One is *docker0* which is the default linux bridge
configured when Docker is set up. It has connection to the outside world, and it has 
inter-container communication enabled by default. Then we have two network segments managed by Docker 
which are *user-defined networks*. These bridges are also Linux bridges. One of these
bridges(*demo_internal*) is an internal network which means it doesn't have connection to the outside, and
the other one(*demo_net*) has connection to the outside world. Finally, there's 
*demo_ns* which is **only a network namespace** and NOT A VIRTUAL SERVER. This
segment has two virtual ethernet interfaces which their final end are connected 
to a Linux bridge *nsbr0*  and to the *server* respectively.


## Docker0

*docker0* is just a Linux bridge with no modifications whatsoever managed by the 
docker engine. It gives the subnet 172.17.0.0/16, so you can fire up plenty of containers 
to play with. An interesting observation is to see if the host's mac address table
 can map as much containers as the network segment valid hosts.
The *docker0* is part of the *docker default networks*. Docker supports three types
of networks: bridge(docker0), none, and host. 
- *Bridge* is just a Linux bridge where all the containers if no network is specified 
are allocated to it. The bridge network is customisable, but the docker daemon needs
to be restarted. Options of this bridge can be found in `docker network inspect bridge`.

| Options          | Values           |
| ---------------- | :--------------: |
| com.docker.network.bridge.default_bridge | true or false |
| com.docker.network.bridge.enable_icc | true or false |
| com.docker.network.bridge.enable_ip_masquerade | true or false |
| com.docker.network.bridge.host_binding_ipv4 | ipv4 to bind |
| com.docker.network.bridge.name | bridge name |
| com.docker.network.driver.mtu | mtu |

- *None* disables network capabilities to containers; in other words, it's attached to itself.
- *Host* adds a container on the host’s network stack.

Let's configure the docker0 bridge. As we said previously, this is pretty much configured 
at installation time. But let's take a look to the network environment before doing it.

		$iptables -L -v && sudo iptables -t nat -L -v
		Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination

		Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination

		Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination
		Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination

		Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination

		Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination

		Chain POSTROUTING (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination

		$ip addr show
		1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
			link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
			inet 127.0.0.1/8 scope host lo
			   valid_lft forever preferred_lft forever
			inet6 ::1/128 scope host
			   valid_lft forever preferred_lft forever
		2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
			link/ether 52:54:00:43:8b:a8 brd ff:ff:ff:ff:ff:ff
			inet 192.168.122.194/24 brd 192.168.122.255 scope global ens3
			   valid_lft forever preferred_lft forever
			inet6 fe80::5054:ff:fe43:8ba8/64 scope link
			   valid_lft forever preferred_lft forever

		$ip route show
		default via 192.168.122.1 dev ens3
		192.168.122.0/24 dev ens3  proto kernel  scope link  src 192.168.122.194


Iptables is accepting everything with no rules defined. Also, the routing table only 
shows the directly connected interface and the default gateway rule. Last, there's only
two interfaces.
Let's install docker. 

        $curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        $sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
        $sudo apt update && sudo apt install docker-ce -y

		# Output might be slightly different from yours
		$sudo iptables -L -v && sudo iptables -t nat -L -v
		Chain FORWARD (policy DROP 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination
			0     0 DOCKER-ISOLATION  all  --  any    any     anywhere             anywhere
			0     0 DOCKER     all  --  any    docker0  anywhere             anywhere
			0     0 ACCEPT     all  --  any    docker0  anywhere             anywhere             ctstate RELATED,ESTABLISHED
			0     0 ACCEPT     all  --  docker0 !docker0  anywhere             anywhere
			0     0 ACCEPT     all  --  docker0 docker0  anywhere             anywhere

		Chain DOCKER (1 references)
		 pkts bytes target     prot opt in     out     source               destination

		Chain DOCKER-ISOLATION (1 references)
		 pkts bytes target     prot opt in     out     source               destination
			0     0 RETURN     all  --  any    any     anywhere             anywhere


		Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
		 pkts bytes target     prot opt in     out     source               destination
			0     0 DOCKER     all  --  any    any     anywhere             anywhere             ADDRTYPE match dst-type LOCAL

		Chain OUTPUT (policy ACCEPT 2 packets, 137 bytes)
		 pkts bytes target     prot opt in     out     source               destination
			0     0 DOCKER     all  --  any    any     anywhere            !localhost/8          ADDRTYPE match dst-type LOCAL

		Chain POSTROUTING (policy ACCEPT 2 packets, 137 bytes)
		 pkts bytes target     prot opt in     out     source               destination
			0     0 MASQUERADE  all  --  any    !docker0  172.17.0.0/16        anywhere

		Chain DOCKER (2 references)
		 pkts bytes target     prot opt in     out     source               destination
			0     0 RETURN     all  --  docker0 any     anywhere             anywhere

		$ip addr show
		3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
			link/ether 02:42:be:33:09:ba brd ff:ff:ff:ff:ff:ff
			inet 172.17.0.1/16 scope global docker0
			   valid_lft forever preferred_lft forever

		$ip route show
		172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1 linkdown


First of all, Docker enables ip forwarding at the kernel level(`echo 1 > /proc/sys/net/ipv4/ip_forward`) 
to have  communication between internal and external hosts.In addition, it creates some 
firewall rules for docker isolation to `DROP` or `ACCEPT` communication between 
containers and other hosts throught the `FORWARD` chain.
It's better to check [this official explanation](https://docs.docker.com/engine/userguide/networking/default_network/container-communication/) 
from the docker site about container communication.

Let's disable inter-container communication (`--icc=false`) and create some containers.


        $sudo systemctl stop docker
        $sudo dockerd --icc=false &

        $docker run -itd --name=c_in_bridge busybox
        $docker run -itd --name=c_in_internal busybox
        $docker run -itd --name=c_in_net busybox
        $docker run -itd --name=web_in_all httpd:2.4

        $sudo iptables -L FORWARD -v

        $sudo iptables -t nat -L POSTROUTING
        Chain POSTROUTING (policy ACCEPT 72 packets, 4997 bytes)
         pkts bytes target     prot opt in     out     source               destination
            0     0 MASQUERADE  all  --  any    !docker0  172.17.0.0/16        anywhere

        $ sudo iptables -L FORWARD -v
        Chain FORWARD (policy DROP 0 packets, 0 bytes)
         pkts bytes target     prot opt in     out     source               destination
            0     0 DOCKER-ISOLATION  all  --  any    any     anywhere             anywhere
            0     0 DOCKER     all  --  any    docker0  anywhere             anywhere
            0     0 ACCEPT     all  --  any    docker0  anywhere             anywhere             ctstate RELATED,ESTABLISHED
            0     0 ACCEPT     all  --  docker0 !docker0  anywhere             anywhere
            0     0 DROP       all  --  docker0 docker0  anywhere             anywhere

        $ip addr show
        5: vethe4f578b@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default
            link/ether 26:1f:8b:1a:7b:82 brd ff:ff:ff:ff:ff:ff link-netnsid 0
            inet6 fe80::241f:8bff:fe1a:7b82/64 scope link
               valid_lft forever preferred_lft foreve
        7: veth896d794@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default
            link/ether 3e:63:f6:3f:0e:62 brd ff:ff:ff:ff:ff:ff link-netnsid 1
            inet6 fe80::3c63:f6ff:fe3f:e62/64 scope link
               valid_lft forever preferred_lft forever
        9: vethf085771@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default
            link/ether a6:c1:31:d7:f1:22 brd ff:ff:ff:ff:ff:ff link-netnsid 2
            inet6 fe80::a4c1:31ff:fed7:f122/64 scope link
               valid_lft forever preferred_lft forever
        11: veth690dd4c@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default
            link/ether 6e:9a:80:a5:01:fc brd ff:ff:ff:ff:ff:ff link-netnsid 3
            inet6 fe80::6c9a:80ff:fea5:1fc/64 scope link
               valid_lft forever preferred_lft forever

Each time a container is run with a published port(`web_in_all`), docker inserts 
 a `POSTROUTING` rule to nat the pusblished ports from the host to the container. 
Also, notice that the rule to communicate between container has been changed from DROP to ACCEPT 
when docker is run with inter-container communication disabled. Furthermore, we see 
four new virtual interfaces, one for each container. Each interface is connected 
to the docker0 bridge in the global namepsace, and the other end is connected to
the container network namespace; however, `vethXXXXX` doesn't say anything of 
which interface belongs to which container on the host. Nonetheless, the following one liner can 
help you identifying the interface index, because each veth pair is created sequentially.

        $DOCKER_ID=`docker ps -aqf "name=web_in_all"`
        $docker inspect --format='{{.State.Pid}}' $(DOCKER_ID) | xargs -I '{}' sudo nsenter -t '{}' -n ethtool -S eth0
        NIC statistics:
             peer_ifindex: 11

Now, let's create the docker networks.

        docker network create -o "com.docker.network.kbridge.enable_icc=false" --internal demo_internal
        docker network create demo_net
        docker network connect bridge web_in_all
        docker network connect demo_internal web_in_all
        docker network connect demo_net web_in_all


## Bibliography
[1] http://stackoverflow.com/a/34497614/3621080
[2] https://github.com/moby/moby/issues/20224
