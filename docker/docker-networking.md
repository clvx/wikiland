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

        # Inspecting iptables and interfaces after docker is installed
        # Output has been cut
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

## User-defined Networks

> In this doc we are not explaining about docker swarm(vxlan) at all. Please
> refer to the [official documentation](https://docs.docker.com/engine/userguide/networking/get-started-overlay/) 
> to learn more.

Docker provides something called user-defined networks which are Linux bridges with
DNS resolution without having to configure your own DNS server. It has several 
network drivers: bridge, overlay, macvlan; and supports network plugins to build
your own network driver. Also, It permits to connect several containers to 
different networks(including the docker0 network). As you can connect a container
to several networks, its external connectivity is provided via the first 
non-internal network, in lexical order.

> Docker has an option for linking containers in `docker0`, with user-defined 
> network I don't see a reason to keep using it. Also, linking is not supported
> in user-defined networks.


Now, let's create the docker networks.

        $docker network create -o "com.docker.network.kbridge.enable_icc=false" --internal demo_internal

        $docker network create demo_net

        $docker network ls
        NETWORK ID          NAME                DRIVER              SCOPE
        77283fff31b2        bridge              bridge              local
        22abcb2ef140        demo_internal       bridge              local
        119bb8423775        demo_net            bridge              local
        e2dfddfecaaa        host                host                local
        11899b8b3162        none                null                local

        # Inspecting iptables after creating the networks 
        # Output has been cut
        $ sudo iptables -L -v
        Chain FORWARD (policy DROP 0 packets, 0 bytes)
         pkts bytes target     prot opt in     out     source               destination
            0     0 DOCKER-ISOLATION  all  --  any    any     anywhere             anywhere
            0     0 DOCKER     all  --  any    docker0  anywhere             anywhere
            0     0 ACCEPT     all  --  any    docker0  anywhere             anywhere             ctstate RELATED,ESTABLISHED
            0     0 ACCEPT     all  --  docker0 !docker0  anywhere             anywhere
            0     0 DOCKER     all  --  any    br-119bb8423775  anywhere             anywhere
            0     0 ACCEPT     all  --  any    br-119bb8423775  anywhere             anywhere             ctstate RELATED,ESTABLISHED
            0     0 ACCEPT     all  --  br-119bb8423775 !br-119bb8423775  anywhere             anywhere
            0     0 ACCEPT     all  --  br-119bb8423775 br-119bb8423775  anywhere             anywhere
            0     0 ACCEPT     all  --  br-22abcb2ef140 br-22abcb2ef140  anywhere             anywhere
            0     0 DROP       all  --  docker0 docker0  anywhere             anywhere

        Chain OUTPUT (policy ACCEPT 158 packets, 19432 bytes)
         pkts bytes target     prot opt in     out     source               destination

        Chain DOCKER (2 references)
         pkts bytes target     prot opt in     out     source               destination

        Chain DOCKER-ISOLATION (1 references)
         pkts bytes target     prot opt in     out     source               destination
            0     0 DROP       all  --  br-119bb8423775 docker0  anywhere             anywhere
            0     0 DROP       all  --  docker0 br-119bb8423775  anywhere             anywhere
            0     0 DROP       all  --  any    br-22abcb2ef140 !172.18.0.0/16        anywhere
            0     0 DROP       all  --  br-22abcb2ef140 any     anywhere            !172.18.0.0/16
            0     0 RETURN     all  --  any    any     anywhere             anywhere

        $sudo iptables -t nat -L -v
        Chain POSTROUTING (policy ACCEPT 2 packets, 138 bytes)
         pkts bytes target     prot opt in     out     source               destination
            0     0 MASQUERADE  all  --  any    !br-119bb8423775  172.19.0.0/16        anywhere
            0     0 MASQUERADE  all  --  any    !docker0  172.17.0.0/16        anywhere

        Chain DOCKER (2 references)
         pkts bytes target     prot opt in     out     source               destination
            0     0 RETURN     all  --  br-119bb8423775 any     anywhere             anywhere
            0     0 RETURN     all  --  docker0 any     anywhere             anywhere


`br-22abcb2ef140` is the bridge for `demo_internal` in my environment. The bridge 
name follows the syntax `br-$(network-id)`. The network id can be obtained by 
`docker network ls` command or `docker network inspect [network-name]`. The same applies
for `demo_net` with its bridge `br-119bb8423775`.
We can see that two new networks has been created. Also, there's one new rule in 
the `FORWARD` chain, and there are two new rules in the `DOCKER-ISOLATION` chain. 
In addition, there's one rule added in the `POSTROUTING` chain and one in the `DOCKER`(PREROUTING) chain 
for `demo_net`. This mean that `demo_net` has NAT capabilities to communicate to the outside world
,but `demo_internal` has not. `DOCKER-ISOLATION` chain isolates completely 
the `demo_internal` network, but for `docker_net` means there's no communication to the docker0 bridge. In the
 FORWARD chain we see that both networks have accepted connections to communicate
 between containers. In the case of `demo_net` it also has communication to the 
outside world.

We can attach/dettach running containers to several networks. At this moment, both 
networks are down, because there's now device connected to the bridge.

        $ip link show
        13: br-22abcb2ef140: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
            link/ether 02:42:0b:7a:5f:f6 brd ff:ff:ff:ff:ff:ff
        15: br-119bb8423775: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
            link/ether 02:42:89:3b:e5:2e brd ff:ff:ff:ff:ff:ff

To connect the containers to the different networks use `docker network connect [network_name] [container]`.

        $docker network connect bridge web_in_all
        $docker network connect demo_internal web_in_all
        $docker network connect demo_internal c_in_internal
        $docker network connect demo_net web_in_all
        $docker network connect demo_net c_in_net
        $docker network disconnect bridge c_in_internal
        $docker network disconnect bridge c_in_internal
        
        # Inspecting the networks
        # Output has been cut
        $docker network inspect bridge
        [
            {
                "Name": "bridge",
                "Id": "b04143660337bc477e4d2b420f3a799340ae2a40c9585ceb81410bf630b6a49c",
                "Driver": "bridge",
                "Internal": false,
                "Containers": {
                    "270dca5b1f6715487b9b8471bdd2c1490c89defb7f311f3d5ccbd03e59687c5e": {
                        "Name": "web_in_all",
                        "EndpointID": "32147fecafb40f926d3193f4a0d61e628530b71c7c2006523e70a27d36fddfd1",
                        "MacAddress": "02:42:ac:11:00:02",
                        "IPv4Address": "172.17.0.2/16",
                        "IPv6Address": ""
                    },
                    "81533d0311f8d634ce84f6da6a13d0745c14a6c13150750f6563674584259175": {
                        "Name": "c_in_bridge",
                        "EndpointID": "d459ffd8177b85b5de687f5fd48e2a1b8c8b2c991af213b24f23532f64bd3ee6",
                        "MacAddress": "02:42:ac:11:00:05",
                        "IPv4Address": "172.17.0.5/16",
                        "IPv6Address": ""
                    },
                },
            }
        ]

        $ docker network inspect demo_internal
        [
            {
                "Name": "demo_internal",
                "Id": "22abcb2ef14008d075290e75bf4f25463c5849617cc736c8b0196de0cabcb86f",
                "Driver": "bridge",
                "Internal": true,
                "Attachable": false,
                "Containers": {
                    "270dca5b1f6715487b9b8471bdd2c1490c89defb7f311f3d5ccbd03e59687c5e": {
                        "Name": "web_in_all",
                        "EndpointID": "9e22fbea0191ee648f4f4553d995fc3d10e20d821200efd01b248c77c9592c45",
                        "MacAddress": "02:42:ac:12:00:02",
                        "IPv4Address": "172.18.0.2/16",
                        "IPv6Address": ""
                    },
                    "56a0bb976ced986f3b7889f5dbcc5f5a3449f61b858b1857103b5c2287b5c40e": {
                        "Name": "c_in_internal",
                        "EndpointID": "1a8300e23320560e64bf984b08e98810427a88ae9b25d1c1bccce86876e3ddad",
                        "MacAddress": "02:42:ac:12:00:03",
                        "IPv4Address": "172.18.0.3/16",
                        "IPv6Address": ""
                    }
                },
                "Options": {
                    "com.docker.network.kbridge.enable_icc": "false"
                },
            }
        ]

        $ docker network inspect demo_net
        [
            {
                "Name": "demo_net",
                "Id": "119bb8423775647a339c3c4cfbb29f30c4c99ad1e66a0606b2799c7c6bf840a4",
                "Internal": false,
                "Containers": {
                    "270dca5b1f6715487b9b8471bdd2c1490c89defb7f311f3d5ccbd03e59687c5e": {
                        "Name": "web_in_all",
                        "EndpointID": "4c69c773b612af883268b91037f2bc2280c4f01f8bb01f86b06635b479595e1e",
                        "MacAddress": "02:42:ac:13:00:02",
                        "IPv4Address": "172.19.0.2/16",
                        "IPv6Address": ""
                    },
                    "a9294f31b168363cd99e3ec1a4b5a125d06dabfa2422f84fcc66b57033bc556c": {
                        "Name": "c_in_net",
                        "EndpointID": "b651d1ba56524e10302a716930e6da42b1997bdd7b371a276dff6cd2fc5b5ca3",
                        "MacAddress": "02:42:ac:13:00:03",
                        "IPv4Address": "172.19.0.3/16",
                        "IPv6Address": ""
                    }
                },
                "Options": {},
            }
        ]

`web_in_all` is the only container connected to all the networks. 

        $ ip route show
        default via 192.168.122.1 dev ens3
        172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1
        172.18.0.0/16 dev br-22abcb2ef140  proto kernel  scope link  src 172.18.0.1
        172.19.0.0/16 dev br-119bb8423775  proto kernel  scope link  src 172.19.0.1
        192.168.122.0/24 dev ens3  proto kernel  scope link  src 192.168.122.194

        $ ip link show
        13: br-22abcb2ef140: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default
            link/ether 02:42:0b:7a:5f:f6 brd ff:ff:ff:ff:ff:ff
        15: br-119bb8423775: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default
            link/ether 02:42:89:3b:e5:2e brd ff:ff:ff:ff:ff:ff

Both bridges now are up after we connect containers to them. There are also 
two rules added to the routing table as directly connected.


#Network namespaces


## Bibliography

[1] http://stackoverflow.com/a/34497614/3621080

[2] https://github.com/moby/moby/issues/20224
