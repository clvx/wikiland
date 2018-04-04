• Subnet:
    ∘ When you create a subnet, you specify the CIDR block for the subnet, which is a subset of the VPC CIDR block. 
    ∘ Each subnet must reside entirely within one Availability Zone and cannot span zones.
    ∘ If a subnet's traffic is routed to an internet gateway, the subnet is known as a public subnet.
    ∘ If you want your instance in a public subnet to communicate with the internet over IPv4, it must have a public IPv4 address or an Elastic IP address (IPv4).
    ∘ If a subnet doesn't have a route to the internet gateway, the subnet is known as a private subnet.
    ∘ Reserved IP's:
        ‣ 10.0.0.0: Network address.
        ‣ 10.0.0.1: Reserved by AWS for the VPC router.
        ‣ 10.0.0.2: Reserved by AWS. The IP address of the DNS server is always the base of the VPC network range plus two; however, we also reserve the base of each subnet range plus two. For VPCs with multiple CIDR blocks, the IP address of the DNS server is located in the primary CIDR. For more information, see Amazon DNS Server.
        ‣ 10.0.0.3: Reserved by AWS for future use.
        ‣ 10.0.0.255: Network broadcast address. We do not support broadcast in a VPC, therefore we reserve this address.
    ∘ When you associate a CIDR block with your VPC, a route is automatically added to your VPC route tables to enable routing within the VPC (the destination is the CIDR block and the target is local).
    ∘ You can associate secondary IPv4 CIDR blocks with your VPC.
    ∘ Each subnet must be associated with a route table, which specifies the allowed routes for outbound traffic leaving the subnet.
    ∘ Every subnet that you create is automatically associated with the main route table for the VPC.
        ‣ You can change the association, and you can change the contents of the main route table.
    ∘ Default subnet:
        ‣ A default subnet is a public subnet, because the main route table sends the subnet's traffic that is destined for the Internet to the Internet gateway.
        ‣ You can make a default subnet into a private subnet by removing the route from the destination 0.0.0.0/0 to the Internet gateway.
        ‣ Instances that you launch into a default subnet receive both a public IPv4 address and a private IPv4 address, and both public and private DNS hostnames.
        ‣ Instances that you launch into a nondefault subnet in a default VPC don't receive a public IPv4 address or a DNS hostname.

• Public subnet vs private subnet:
    ∘ How instances in that subnet access the Internet.
    ∘ The instances in the public subnet can send outbound traffic directly to the Internet, whereas the instances in the private subnet can't.
    ∘ The instances in the private subnet can access the Internet by using a network address translation (NAT) gateway that resides in the public subnet. 
    ∘ Any additional subnets that you create use the main route table by default, which means that they are private subnets by default. If you want to make a subnet public, you can always change the route table that it's associated with.

• A public subnet is a subnet that allow its instances to access the Internet via an Internet Gateway
• A private subnet allows its instances to access the Internet via either a Network Address Translation server (NAT) or via Amazon’s managed NAT service (NAT Gateway).
    ∘ In order to make a subnet allow access to the Internet via an Internet Gateway or a NAT Gateway you have to make sure that the route tables for the subnet are set up in a way to direct traffic to the correct gateway.
• The ELB is the entry point for your application and it directs traffic to your application servers.
    ∘ Note that the ELB needs to be available in all 3 availability zones.
    ∘ Behind the scenes AWS provisions multiple instances of the ELB based on what availability zones have EC2 instances behind that load balancer.
• The Bastion host is the server that will allow you to connect to your servers in the private subnets via SSH.
• Application Layer is where your application servers live.
• Database Layer is where the databases live.
    ∘ The only way to access these databases is by connecting to them from the application layer.
    ∘ One advantage of using RDS is that we can have a failover database instance in a separate availability zone.
    ∘ We can also have one or more read-only RDS instances to take some of the load of the main database.
    Public Subnets
    10.0.0.0/24 -> local
    0.0.0.0/0 -> internet-gateway-id

    Private Subnets
    10.0.0.0/24 -> local
    0.0.0.0/0 -> NAT-gateway-id

    The public (top) layer will host an internet-facing Elastic Load Balancer (ELB) and a Bastion host.

• How to create an availability zone? 
    ∘ Las AZs no las creas, esas Amazon las define por región. Tú decides en cuál de todas las AZs poner tus ec2 o RDS.
• How to create a private subnet?
• How to create a load balancer?
• How to create an auto scaling group?
• How to create an ec2 instance?
    ∘ By default, instances launched into a nondefault VPC are not assigned a public IPv4 address. To be able to connect to your instance in the public subnet, you can assign a public IPv4 address now, or allocate an Elastic IP address and assign it to your instance after it's launched. To assign a public IPv4 address now, ensure that you choose Enable from the Auto-assign Public IP list. You do not need to assign a public IP address to an instance in the private subnet.
• How to create a NAT service? 
    ∘ You must specify an Elastic IP address for your NAT gateway; if you don't have one, you must first allocate one to your account. If you want to use an existing Elastic IP address, ensure that it's not currently associated with another instance or network interface. The NAT gateway is automatically created in the public subnet of your VPC.
• How to connect the private subnet to the NAT Service? 
• How to create an availability zone?
• How to connect a load balancer to cloud.bitclvx.com?
• What happens if I leave nodes in the public subnet? 
• How to enable security groups to the AWS objects? 
    ∘ Verify which kinda of access the default security group provides?
• How to enable redundancy in a load balancer in different AZ?  

• Security:
    ∘ Security groups control inbound and outbound traffic at the instance level.
        ‣ An instance that's launched into the VPC is automatically associated with the default security group if you don't specify a different security group during launch.
        ‣ The default security group for a VPC has rules that automatically allow assigned instances to communicate with each other.
        ‣ When you launch an instance in a VPC, you can associate one or more security groups that you've created.
        ‣ When you launch an instance in a VPC, you can assign up to five security groups to the instance.
        ‣ About traffic:
        ‣ WebServerSG: Specify this security group when you launch the web servers in the public subnet.
        ‣ DBServerSG: Specify this security group when you launch the database servers in the private subnet.
        ‣ Specific features:
            • Operates at the instance level (first layer of defense).
            • Supports allow rules only.
            • When you create a security group, it has no inbound rules. Therefore, no inbound traffic originating from another host to your instance is allowed until you add inbound rules to the security group.
            • By default, a security group includes an outbound rule that allows all outbound traffic. You can remove the rule and add outbound rules that allow specific outbound traffic only. If your security group has no outbound rules, no outbound traffic originating from your instance is allowed.
            • Is stateful: Return traffic is automatically allowed, regardless of any rules.
            • We evaluate all rules before deciding whether to allow traffic.
            • Applies to an instance only if someone specifies the security group when launching the instance, or associates the security group with the instance later on.
            • Security groups are associated with network interfaces.
    ∘ Network ACLs control inbound and outbound traffic at the subnet level.
        ‣ Specific features:
            • Default network ACL allows all inbound and outbound IPv4 traffic and, if applicable, IPv6 traffic.
            • By default, each custom network ACL denies all inbound and outbound traffic until you add rules.
            • You can associate a network ACL with multiple subnets; however, a subnet can be associated with only one network ACL at a time.
            • Operates at the subnet level (second layer of defense).
            • Supports allow rules and deny rules.
            • Is stateless: Return traffic must be explicitly allowed by rules.
            • We process rules in number order when deciding whether to allow traffic.
            • Automatically applies to all instances in the subnets it's associated with (backup layer of defense, so you don't have to rely on someone specifying the security group).

• VPC: Virtual Private Network. 
    ∘ It needs to define a CIDR in creation.
    ∘ A VPC spans all the Availability Zones in the region.
    ∘ Default VPC:
        ‣ Create a VPC with a size /16 IPv4 CIDR block (172.31.0.0/16)
        ‣ Create a size /20 default subnet in each Availability Zone.
        ‣ Create an internet gateway and connect it to your default VPC.
        ‣ Create a main route table for your default VPC with a rule that sends all IPv4 traffic destined for the internet to the internet gateway.
        ‣ Create a default security group and associate it with your default VPC.
        ‣ Create a default network access control list (ACL) and associate it with your default VPC.
        ‣ Associate the default DHCP options set for your AWS account with your default VPC.
        ‣ To view your default VPC and subnets using the Amazon VPC console:
        • In the Default VPC column for VPC section, look for a value of Yes. Take note of the ID of the default VPC.
        • In the Subnet section, look for the ID of the default VPC. The returned subnets are subnets in your default VPC.

• Elastic Network Interface: 
    ∘ Virtual network interface which can include:
        ‣ A primary private IPv4 address.
        ‣ One or more secondary private IPv4 addresses.
        ‣ One Elastic IP address per private IPv4 address.
            • One public IPv4 address, which can be auto-assigned to the network interface for eth0 when you launch an instance.
        ‣ One or more security groups.
        ‣ A MAC address.
    ∘ When you move a network interface from one instance to another, network traffic is redirected to the new instance. 
    ∘ Each instance in your VPC has a default network interface that is assigned a private IPv4 address from the IPv4 address range of your VPC which is not detachable.
    ∘ You can create and attach an additional network interface to any instance in your VPC.

• Route Tables: maintains the routing table for each subnet. 
    ∘ Only one route table per subnet, but multiple subnets can use the same route table. 
    ∘ Your VPC has an implicit router.
    ∘ Your VPC automatically comes with a main route table that you can modify.
    ∘ You can create additional custom route tables for your VPC.
    ∘ If you don't explicitly associate a subnet with a particular route table, the subnet is implicitly associated with the main route table. 
    ∘ You cannot delete the main route table, but you can replace the main route table with a custom table that you've created.
    ∘ We use the most specific route that matches the traffic to determine how to route the traffic. 
    ∘ Every route table contains a local route for communication within the VPC over IPv4. If your VPC has more than one IPv4 CIDR block, your route tables contain a local route for each IPv4 CIDR block. You cannot modify or delete these routes. 
    ∘ When you add an Internet gateway, an egress-only Internet gateway, a virtual private gateway, a NAT device, a peering connection, or a VPC endpoint in your VPC, you must update the route table for any subnet that uses these gateways or connections. 
    ∘ One way to protect your VPC is to leave the main route table in its original default state (with only the local route), and explicitly associate each new subnet you create with one of the custom route tables you've created.

• Internet Gateways: Horizontally scaled, redundant, and highly available VPC component that allows communication between instances in your VPC and the Internet. 
    ∘ Provides a target in your VPC route tables for Internet-routable traffic.
    ∘ Performs network address translation (NAT) for instances that have been assigned public IPv4 addresses. 
    ∘ Enabling Internet Access:
        ‣ Attach an Internet gateway to your VPC.
        ‣ Ensure that your subnet's route table points to the Internet gateway.
        ‣ Ensure that instances in your subnet have a globally unique IP address (public IPv4 address, Elastic IP address, or IPv6 address).
        ‣ Ensure that your network access control and security group rules allow the relevant traffic to flow to and from your instance.

• NAT Gateways: Enable instances in a private subnet to connect to the Internet or other AWS services, but prevent the Internet from initiating a connection with those instances.
    ∘ To create a NAT gateway, you must specify the public subnet in which the NAT gateway should reside.
    ∘ You must also specify an Elastic IP address to associate with the NAT gateway when you create it.
        ‣  You cannot disassociate an Elastic IP address from a NAT gateway after it's created. 
        ‣ To use a different Elastic IP address for your NAT gateway, you must create a new NAT gateway with the required address, update your route tables, and then delete the existing NAT gateway if it's no longer required.
    ∘ After you've created a NAT gateway, you must update the route table associated with one or more of your private subnets to point Internet-bound traffic to the NAT gateway.
    ∘ Each NAT gateway is created in a specific Availability Zone and implemented with redundancy in that zone.
        ‣ To create an Availability Zone-independent architecture, create a NAT gateway in each Availability Zone and configure your routing to ensure that resources use the NAT gateway in the same Availability Zone. 
    ∘ A NAT gateway supports the following protocols: TCP, UDP, and ICMP.
    ∘ When a NAT gateway is created, it receives a network interface that's automatically assigned a private IP address from the IP address range of your subnet.
    ∘ A NAT gateway can support up to 55,000 simultaneous connections to each unique destination

• DNS:
    ∘ When you launch an instance into a default VPC, AWS provides the instance with public and private DNS hostnames that correspond to the public IPv4 and private IPv4 addresses for the instance.
    ∘ When you launch an instance into a nondefault VPC, AWS provides the instance with a private DNS hostname and might provide a public DNS hostname, depending on the DNS attributes you specify for the VPC and if your instance has a public IPv4 address.
    ∘ You can use the private DNS hostname for communication ONLY between instances in the same network.
        ‣ enableDnsHostnames: Indicates whether the instances launched in the VPC get public DNS hostnames. 
        ‣ enableDnsSupport: Indicates whether the DNS resolution is supported for the VPC. 

• Elastic IP Addresses
    ∘  Static, public IPv4 address designed for dynamic cloud computing.
    ∘  You can associate an Elastic IP address with any instance or network interface for any VPC in your account.
    ∘ With an Elastic IP address, you can mask the failure of an instance by rapidly remapping the address to another instance in your VPC.
    ∘ Basics:
        ‣ You first allocate an Elastic IP address for use in a VPC, and then associate it with an instance in your VPC.
        ‣ You can associate an Elastic IP address with an instance by updating the network interface attached to the instance. 
        ‣ If you associate an Elastic IP address with the eth0 network interface of your instance, its current public IPv4 address is released to the EC2-VPC public IP address pool. If you disassociate the Elastic IP address, the eth0 network interface is automatically assigned a new public IPv4 address within a few minutes.
        ‣ You can move an Elastic IP address from one instance to another. 
        ‣ Your Elastic IP addresses remain associated with your AWS account until you explicitly release them. 
        ‣ You're limited to five Elastic IP addresses.
        ‣ An Elastic IP address is accessed through the Internet gateway of a VPC.



https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ElasticNetworkInterfaces.html
https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html
