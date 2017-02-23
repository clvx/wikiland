#OpenVPN

###VPN(Virtual Private Network)

Allows an administrator to create a "local" network 
between multiple computers on varying network segments where the traffic inside 
the tunnel is no longer identifiable.
- None device along the connection path can't see any other traffic than the vpn.
- A VPN not only encrypts the traffic within, it hides and protects individual 
data streams from those outside the tunnel.
- Based on the SSL/TLS protocol; OpenVPN also uses HMAC in combination with a 
digest(or hashing) algorithm for ensuring integrity of the packets delivered. 
The connection is secured in most cases by using X.509 certificates or 
pre-shared keys. connection. 
- It uses a virtual network adapter(TUN/TAP) as an interface between the 
user-level OpenVPN software and the operating system.
- OpenVPN has the notion of a control channel and a data channel, both of which
 are encrypted and secured differently. However, all traffic passes over a 
single UDP or TCP connection. 
    - The control channel is encrypted and secured using SSL/TLS. t
    - The data channel is encrypted using a custom encryption protocol.
- Default protocol and port is UDP 1194.

###Vpn Uses 
• Privacy mostly.
• To connect different private networks over the Internet as seen as a big private network.
Encryption: Ensures that other parties that may be monitoring traffic between systems cannot decode and further analyze otherwise sensitive data.
Authentication: 
• User or system authentication that ensures those connecting to the service are authorized. It could be per-user certificates, or username/password combination.
∘ Rules specific to a giver user can be negotiated such as specific routes, firewall rules, or other scripts or utilities.
• To protect the communication stream. In this case, a method of signing each packet sent is established. Each system verifies the VPN packets it receives are properly signed before decrypting the payload.
∘ By authenticating packets that are already encrypted, a system can save processing time by not even decrypting packets that not meet the authentication rules.

Advantages and disadvantages of OpenVPN.
• Easy configuration and deployment.
• It works on restricted and NAT'ted networks. 
• Lack of scalability and its dependence on the installation of client-side software.
• Lack of GUI for configuration and management.

OpenVPN internals:
• tun/tap driver is a virtual network adapter that is treated by the operating system as either a point-to-point adapter(tun-style) for IP-only traffic or as a full virtual Ethernet adapter for all types of traffice(tap-style). At the backend of this adapter is an application, such as OpenVPN, to process the incoming and outgoing traffic.
∘ Linux, Mac OS include a tun kernel driver, which is capable of tun/tap style operations.
∘ Windows, a special NDIS driver call the TAP-WIN32 adapter is used.
∘ See Figure Page 17. 
• OpenVPN flow:
∘ The application hands over the packet to the operating system.
∘ The OS decides using normal routing rules that the packet needs to be routed via the VPN.
∘ The packet is then forwarded to the kernel tun device.
∘ The kernel tun device forwards the packets to the (user-space) OpenVPN process.
∘ The OpenVPN process encrypts and signs the packet, fragments it if necessary, and then hands it over to the kernel again to send it to the address of the remote VPN endpoint.
• OpenVPN will always have less performance than a regular connection - Bottleneck working with >= 1Gb/s 
• If UDP (mode udp) works for you, then use it; if not, then try TCP(mode tcp-server and mode tcp-client).
∘ UDP is a connectionless or lossy protocol; if a packet is dropped in transit, then the network stack does not transparently correct this.  If OpenVPN is set as UDP and the traffic is UDP there's now way to have a realiable connection.
∘ TCP packets are a connection-oriented  protocol; packets are sent and delivered using a handshake protocol, ensuring the delivery of each packet to the other side. If OpenVPN is set as TCP and the traffic is TCP there's going to be overhead if a tunnel packet or data packet needs to be retransmitted.
• OpenVPN implements TLS over UDP, but a firewall that uses Deep Packet Inspection(DPI) can easily filter out OpenVPN traffic.
• OpenVPN offers features to protect against DoS attacks by signing the control channel packets using a special static key(--tls-auth ta.key 0|1). Data channel packets, which are sent over the same UDP or TCP connection, are signed completely differently and are very readily distinguished from HTTPS traffic.
• OpenVPN uses two virtual channels to communicate between the client and the server:
∘ A TLS control channel to exchange configuration information and cipher material between the client and server.
‣ The control channel is initiated using a TLS-style protocol. During control channel initialization, the encryption cipher and hashing algorithm are negotiated between the client and the server.
‣ The control channel cipher and hashing algorithm are normally negotiated at startup.
• openvpn --show-tls, lists available combinations of ciphers and hashing algorithms.
• tsl-ciphers [CIPHER], specify a cipher and hashing algorithm in the configuration file.
∘ A data channel over which the encrypted payload is exchanged.
‣ Encryption and authentication algorithms for the data channel are not negotiable, but they are set in both the client and server configuration files for OpenVPN.
‣ Then encryption cipher and hashing algorithm are controlled using the --cipher and --auth options. If the cipher and authentication algorithm are not specified, the bf-cbc and sha1 are used.
• openvpn --show-ciphers, lists available encryption ciphers with its keysize. Each cipher may be used as a parameter to --cipher option, and the keysize may be modified using --keysize directive.
• openvpn --show-digests, lists all the authentication(HMAC-signing) algorithms, and may be modified using the --auth option. A message digest is used in conjunction with the HMAC function to authenticate received packets. 
∘ The ciphers are used to encrypt the payload, while the HMAC function makes use of a digest or hashing algorithm to authenticate incoming packets.

Point-to-point
• OpenVPN is configured using pre-shared secret keys for predefined endpoints, and only a single endpoint can connect to a server instance at a time.
• Pros: 
∘ It's a very easy to set up.
∘ There's no need for public key infraestructure(PKI) or x.509 certificates.
• Cons:
∘ Only two endpoints can be used by a single connection.
∘ The secret key must be copied to the remote endpoint using a secure channel.
∘ Not possible to encrypt the secret key using a passphrase, like is possible when using x.509 public/private keys.
∘ Security depends entirely on the security and strength of the pre-shared secret key. Also, there is no perfect forwarding secrecy (PFS) in this mode. Without PFS, an attacker may record all encrypted VPN traffic. If the attacker manages to break the encryption at some point, then all recorded VPN traffic can be decrypted.
• TAP mode: Provides an interface to pass full Ethernet frames over the VPN tunnel. The IP assignment for a tap device is different from a tun device, as a tap device acts as a regular network adapter, which needs to be assigned a single IP address and a netmask.
• Topology subnet: When using --topology-subnet, a single IP address and netmask are assigned to the tun interface, with no peer address specified.
• Generating a secret key: openvpn --genkey --secret secret.key
• Configuration file: 
∘ Each option can be specified on the command line using --<some option> <option-arguments> .
∘ It can also be specified in a config file removing the two dashes  in front of the command line argument  <some option> <option-arguments>
∘ The config file is specified on the command-line using the --config <path> option.
‣ All options specified before the --config <path> option are overridden by the options specified inside the config file. All options specified after the --config option overrule the options in the config file.
• Route, net_gateway, vpn_gateway and metrics:
∘ vpn_gateway is a special OpenVPN keyword and it specifies the VPN remote endpoint address. Normally, this keyword does not have to be specified, unless it is also necessary to specify the metric for this route.
∘ route <network> <netmask> vpn_gateway <metric>
‣ gateway can either be explicitly set as an IPv4 address, or the special keyword vpn_gateway or net_gateway can be used. If no gateway and no metric are specified, then vpn_gateway is used.
‣ route-metric m, applies to all routes. If one wishes to overrule the metric for a particular route, then it is required to specify the gateway, followed by the metric for that particular route.
‣ route-delay ensures that the routes are added after all connections are available.
Site A LAN: Client
ipv4: 192.168.4.0/24
ipv6: 2001:610:120::168:4:0
tun0: 10.200.0.2
tun0-ipv6: 2001:610:120::200:0:2

Site B LAN: Server
ipv4: 192.168.122.0/24
ipv6: 2001:610:120::168:122:0
tun0: 10.200.0.1
tun0-ipv6: 2001:610:120::200:0:1

movpn-02-02-server.conf:
dev tun					# Tells OpenVPN to open the first available tun adapter. 
proto udp				# Default, but better to specify it.
local openvpnserver.example.com 	# If not specified, it will listen on 0.0.0.0.
lport 1234 				# local port with default 1194.
remote openvpnclient.example.com	# Remote host from which OpenVPN process will 	accept incoming connections. If this address is not specified, it will accept inconming connections from all addresses.
rport 4321				# Remote port that OpenVPN will connect to. Normally, this is specified using port but when a different local port is used, it is handier to explicitly specify rport.

secret secret.key 0			# The secret key is used by OpenVPN for both encrypting and authenticating(signing) each packet. The default encryption cipher is the Blowfish(bf-cbc 128 bits) and default HMAC algorithm is SHA1 160 bits. By adding a direction flag, we can specify that different keys are to be used. 
ifconfig 10.200.0.1 10.200.0.2		# /sbin/ip is used to set up the tun adapter. The ip address specified is assigned, along with a default maximun transfer unit(MTU) of 1500 bytes.
route 192.168.4.0 255.255.255.0		# /sbin/ip route is used to configure the system routing tables. This is the same as ip route add 192.168.4.0/24 via 10.200.0.1. IP forwarding needs to be enabled echo 1 > /proc/sys/net/ipv4/ip_forward. Also note that a route back is needed on the other peer.

tun-ipv6
ifconfig-ipv6 2001:610:120::200:0:1 2001:610:120::200:0:2

user nobody				# Instruct OpenVPN to drop Unix user nobody and group it after the connection has come up.
group nobody 				# use 'group nogroup' on Debian/Ubuntu
# Instruct OpenVPN to not reopen the tun device or generate new keying material whenever the tunnel is restarted. Useful in combination with user nobody, as the user nobody normally does not have access rights to open a new tun interface.
persist-tun				
persist-key
# To mantain the connection up, even if there's no traffic flowing over the tunnel.
keepalive 10 60				
ping-timer-rem

verb 3
daemon
log-append /var/log/openvpn.log

Also, routing rules:
# route add -net 10.200.0.0/24 gw 192.168.4.100
# route add -net 192.168.122.0/24 gw 192.168.4.100

movpn-02-02-client.conf
dev tun	
proto udp
local openvpnclient.example.com
lport 4321
remote openvpnserver.example.com
rport 1234

secret secret.key 1
ifconfig 10.200.0.2 10.200.0.1
route 192.168.122.0 255.255.255.0	# /sbin/ip route is used to configure the system routing tables. This is the same as ip route add 192.168.4.0/24 via 10.200.0.2

tun-ipv6
ifconfig-ipv6 2001:610:120::200:0:2 2001:610:120::200:0:1

user nobody
group nobody #use 'group nogroup' on Debian/Ubuntu
persist-tun
persist-key
keepalive 10 60 
ping-timer-rem

verb 3
daemon
log-append /var/log/openvpn.log

Also, routing rules:
# route add -net 10.200.0.0/24 gw 192.168.122.1
# route add -net 192.168.4.0/24 gw 192.168.122.1


Client/Server Mode with tun devices
• The server is a single OpenVPN process to which multiples clients can connect. Each authenticated and authorized client is assigned an IP address from a pool of IP addresses that the OpenVPN server manages. Clients cannot communicate directly with one another. All traffic flows via the server.
• Advantages:
∘ Control: The VPN server admin can control which traffic is allowed to flow between clients.
∘ Ease of deployment: 
• Disadvantages:
∘ Scalability: It can become a bottleneck in large scale VPN setups.
∘ Performance: It will always be lower when compared to a direct client-to-client connection.
• Only if there are specific requirements to route non-IP traffic or if there's a need to form a single network broadcast domain, then this deployment model will not suffice.
movpn-04-01-server.conf
proto udp
port 1194
dev tun
server 10.200.0.0 255.255.255.0					#Puts OpenVPN in server mode. The IP subnet and subnet mask specify the subnet and mask to use for the VPN server and clients. this is expanded as follows:
													# mode server
													# tls-server
													# push "topology subnet"
													# ifconfig 10.200.0.1 255.255.255.0
													# ifconfig-pool 10.200.0.2 10.200.0.254	 255.255.255.0
													# push "route-gateway 10.200.0.1"
topology subnet
persist-key
persist-tun										# Instruct OpenVPN to neither reopen the tun device, nor generate new keying material whenever the tunnel is restarted. These options are particulary useful in combination with user nobody, as the user nobody normally does not have the access right to open a new tun interface.
keepalive 10 60									# Used to remain the VPN connection remains up, even if there is no traffic flowing over the tunnel. This is expanded as follows:
# ping 10											# Send a ping message to each client every 10 seconds
# ping-restart 120								# Restart the connection if a client does not respond within 120 seconds.
# push "ping 10"									# Push the ping statements to each client.
# push "ping-restart 60"

remote-cert-tls client							# Instructs the OpenVPN server to only allow connections from VPN clients that have a certificate with the X.509 EKU attributes set to TLS Web Client Authentication. This prevents a hacker from setting up a rogue OpenVPN server using a client certificate.
tls-auth 	/etc/openvpn/movpn/ta.key 0		# Enables a kind of "HMAC firewall" on OpenVPN's TCP/UDP port, where TLS control channel packets bearing an incorrect HMAC signature  can  be  dropped  immediately without response.
dh 			/etc/openvpn/movpn/dh2048.pem	#Without this file, the server cannot establish a secure TLS connection with clients.
ca			/etc/openvpn/movpn/movpn-ca.crt
cert		/etc/openvpn/movpn/server.crt	
key		/etc/openvpn/movpn/server.key		# This file needs to be readable by the root user only, as anyone with read access to private keys can decrypt OpenVPN traffic.

user nobody
group nobody

verb 3
daemon											# Tells OpenVPN to demonize itself.
log-append	/var/log/openvpn.log

push "route 192.168.122.0 255.255.255.0" 				# Push a static route to the client; otherwise, in the client must be a route to the 192.168.122.0 network.
push "redirect-gateway def1" 						# redirects all traffic through VPN.

status /var/run/openvpn.status 3

movpn-04-01-client.conf
client
proto udp
remote openvpnserver.example.com
port 1164
dev tun
nobind											# Instructs OpenVPN client not to bind to the port specified using port. Instead, the OpenVPN client will use a port in the anonymous port range, which is typically 1024-65335

remote-cert-tls	server							# Instructs the OpenVPN client to only allow connections to a VPN server that has a certificate with the X.509 EKU attribute set to TLS Web Server Authentication. This prevents a malicious client from setting up a rogue OpenVPN server to attract connection from other VPN users.
tls-auth	/etc/openvpn/movpn/ta.key 1		# Enables a kind of "HMAC firewall" on OpenVPN's TCP/UDP port, where TLS control channel packets bearing an incorrect HMAC signature  can  be  dropped  immediately without response.
ca			/etc/openvpn/movpn/movpn-ca.crt
cert		/etc/openvpn/movpn/client1.crt
key		/etc/openvpn/movpn/client.key		 This file needs to be readable by the root user only, as anyone with read access to private keys can decrypt OpenVPN traffic.

Topology subnet vs topology net30
• Topology net30 is the current default. OpenVPN sets up a Point-to-Point network interface for each client and it assigns a /30 subnet to each.
‣ E.g. server 10.200.0.0 255.255.255.0 with topology net30 causes OpenVPN assign the follow IP blocks:
• Server is assigned from 10.200.0.0 to 10.200.0.3
• First client is assigned from 10.200.0.4 to 10.200.0.7
∘ 10.200.0.4: Network address.
∘ 10.200.0.5: Virtual endpoint address, not pingable.
∘ 10.200.0.6: Client VPN IP address.
∘ 10.200.0.7: Broadcast address.
• Topology subnet allows OpenVPN to assign a single IP address to all clients instead of point-to-point blocks as net30.
• Second client is assigned from 10.200.0.8 to 10.200.0.11 and so on.

Routing and server-side routing
• For routing a push "route [network] [mask] [gateway] [metric]" can be used, or setting up a route directly in the client, but this doesn't scale well.
∘ The route option accepts up to four parameters, two mandatory and two optional where gateway can be explicitly set as an IPv4 address or either of the special keywords vpn_gateway or net_gateway. If no gateway and no metric are specified, then vpn_gateway is used.
∘ vpn_gateway, The remote VPN endpoint address. This keyword doesn't have to be specified, UNLESS it's also necessary to specify the metric for this route.
∘ net_gateway, useful to specify a subnet that should explicitly not be routed via the VPN.
• Also ip forwarding must be enable for routing to work:
∘ In Linux: echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward
• The metric has a default metric that can be set using route-metric m, which then applies to all routes. If you wish to overrule the metric for a particular route, then it is required to specify the gateway followed by the metric for the particular route.

Redirecting the default gateway
• redirect-gateway [def1 bypass-dhcp bypass-dns], Automatically execute routing commands to cause all outgoing IP traffic to be redirected over the VPN.  This is a client-side option. This option performs three steps:
∘ (1) Create a static route for the --remote address which forwards to the pre-existing default gateway.  This is done so that (3) will  not  create  a  routing loop.
∘ (2) Delete the default gateway route.
∘ (3)  Set  the  new default gateway to be the VPN endpoint address (derived either from --route-gateway or the second parameter to --ifconfig when --dev tun is specified).
∘ When the tunnel is torn down, all of the above steps are reversed so that the original default route is restored.
