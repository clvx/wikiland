# AWS

## AWS Global Infrastructure

### Regions

Geography areas where AWS operates.

- Independent between regions.
- Content in a region stays in a region.
- Designed for fault tolerance.

### Availability Zones

- Collection of one or more data centers.
- Designed to enable disaster recovery.
    - Redundant power.
    - Redundant network.
- Each AZ is identified with a letter: `a,b,c,d,..`
- AZ name might differ between AWS accounts.
- Each AZ name maps to an AZ id.
- Provides a fast connection to other zones in the same region.
- Each AZ can contain subnets which can be public or private.
    - A subnet can only live in an AZ.

### Edge Locations
- Content delivery system to end end users(_cloudfront_)
- One or more racks in a datacenter.


### VPC

- Allows you to provision a logically-isolated section with complete control over 
your virtual network, selection of IP's, creation of subnets, config of routing 
tables and network gateways.
- By default up to five VPC's in a single region per account.
    - It can be increased by request.
- A VPC lives in a region as part of an AWS account.
    - A VPC cannot be spanned between regions.
- It can contain more than one AZ.
- Internet Gateway is used to connect a VPC to the Internet.
- Private services are inside of a VPC.
- Public services are outside of a VPC.

    #Creating a VPC
    - VPC Name Tag
    - CIDR Block -> Cannot be changed after creation: /28, /16
    - Tenancy:
    >- default
    >- dedicated: forces all resources to be created physically isolated from other
    AWS accounts

### Subnets

- A segment of a VPC that lives entirely withian a single AZ.
- Subnets cannot span more than one AZ.
- Subnets can be public, private, or VPN only.

    #Subnet address range
    -> 192.168.0.0 - 192.168.255.255
    -> 172.16.0.0 - 192.31.255.255
    -> 10.0.0.0 - 10.255.255.255

#### Consideration to choose a VPC CIDR Block
- Avoid addressing overlapping with other networks.
    - Integration with other VPC's.
    - Integration with on-premise networks.
- Future address comsuption(subnetting).
- All default VPC's use the same address range.
    - `172.131.0.0/16`

    #Creating a subnet
    - Specify target AZ
    - Determine CIDR range
    >- The smallest CIDR range is /28 netmask
    >- Largest CIDR range is /16 netmask

- AWS Reserved addresses
    - First 4 ipv4 addresses of every subnet:
        - 1st addr: `network address`
        - 2nd addr: `vpc router`
        - 3rd addr: `dns server`
        - 4th addr: `future use`
    - Last ipv4 adddress:
        - last addr: `brooadcast`

### VPC Router

First place packets hit when leaving resources that are in a VPC/subnet.

    DIAGRAM FOR VPC Router

- Presented in every subnet.

#### Route Table

- It can contain multiple routes entries which define the next hop in the network.
- It accepts cidr ranges, prefixes or some aws resource ids.
- There's a default VPC Router with a default route entry in a VPC to communicate 
all subnets in a VPC between each other.
- Custom tables are support which have preference over the default main route table.

### Elastic Network Interface(ENI)
A virtual network interface that you can attach to an instance in a VPC.

- Created inside a VPC.
- Associated with a subnet.
- ENI attributes:
    - ipaddr
    - mac address
    - At least one security group.
- An instance will have at least one ENI upon creation.
    - This ENI cannot be deleted or dettached.
    - It will exist for the lifecycle of the instance.
    - The number of ipaddr is limited by the instance type.
    - An external IP will be auto assigned upon creation(if specified).
    - An Elastic External IP is required to reach the ENI by the Internet.
- Source/destination check.
- Security groups are added to ENI's instead of an instance.
- Any non default ENI can be detached and reattached to different instances in the 
same network/AZ.
- NIC teaming is not supported.

### Internet Gateway
It allows communication between instances and the Internet translating private IP 
addresses to public IP. 
    - *Do not confuse with NAT*.

- Created per region per VPC.
    - It sits at the edge of a VPC facing the Internet.
- A route table entry with a default route pointing to the IGW is needed to 
reach the Internet.
- An EIP is required to communicate with the IGW.
- IGW only works with resources that have a public IP.

| Elastic IP | Dynamic External IP |
| - | - |
| Allocation from AWS's ipv4 address pool | Assigned upon EC2 creation |
| Assigned EIP to an EC2 instance(underlying ENI) | Cannot dissassociate address from EC2 instance after lunch |
| You choose when to release back to AWS | Automatically released when you stop or terminate the EC2 instance |

    DIAGRAM FOR EIP/IGW

### Security Groups(SG)
Object based filters within AWS that can be applied to many resources.

- Security groups can be used only in the VPC it was created in.
- There's a default security group per VPC.
- A Security group can be applied to a set of instances.
- The product of rules are applied when multiple security groups are attached.
- Security groups are attached to an object's ENI.
- Stateful.

### Network Access Control List(NACL)
Applied to any resource launched in any subnet.

- There's a default NACL  when a VPC is created which is assigned to all the 
VPC subnets by default.
- Only one NACL associated with a subnet.
- NACL's are subnet scoped objects.
    - They are applied to any instance in the subnet.
- Stateless.
- TIP: create rules for ephemeral ports for different OS's.

| Security Groups(SG) | Network Access Control Lists(NACL) |
| - | - |
| Applied at the resource level(ENI) | Applied at the subnet level |
| Resource have multiple SG's. | A subnet is associated with one NACL. A NACL can be associated with multiple subnets |
| Stateful | Stateless |
| Only allow rules. Implicit deny | Allow and deny rules are allowed. Implicit deny |
| Rule evaluation is in any order | Rules are evaluated in order |
| SG's can reference themselves | |

#### Ephemeral Ports
Short lived port ranges used by the OS for client/server communication.
- Linux: `32768 - 61000`
- Windows: `49152 - 65535`
- ELB: `32768 - 61000`
- NAT GW: `1024 - 65535`

### NAT Gateway
It allows resources with a privte ip to access the Internet doing port translation.

- AWS managed service.
- Subnet + EIP are required.
- It offers elasticity to scale and high availability using different AZ.
- Up to 45Gbps of bandwidth.
- Up to 5 NAT Gateways per AZ by default.
- Cost depends on the amount of data that is sent through the NAT GW.
- A NAT GW cannot be associated with a SG, but SG's can be associated with 
resources behind a NAT GW.

### VPC Endpoint
- A way to access a public AWS service within a VPC without crossing the VPC 
boundaries.
- Endpoints are a regional service.
- Endpoints are not extendable accross VPC boundaries.
- DNS resolution is required.
    - The internal VPC DNS redirects requests to the VPC Endpoint thus requiring 
    DNS resolution with the VPC.
- VPC Endpoint policies do not override resource-specific policies.
- Multiple VPC Endpoints
    - You can have multiple VPC endpoints within the same VPC(even for the same service).
    - Each endpoint can have its own policy.
    - Each endpoint can applied to different subnets.

#### VPC Gateway Endpoints
- VPC endpoint for AWS services. For example, S3, DynamoDB, etc.
- It sits architecturally inside the VPC boundaries.
- It can be referenced as a route table entry using its VPC Endpoint ID.

    VPC Gateway Endpoint creation
    - VPC
    - Server destination(prefix)
    - Policy(restrict access to the service)
    - Route entry to subnet route table

### VPC Peering
It allows communication between VPC's.

    VPC Peering creation
    - Source VPC
    - Destination VPC <- Acceptor needs to approve peering
    - Route table entries to communicate VPC's.

- Transitive peering is not allowed.
    - IMPORTANT: communication through the resources can be achieved.
- DNS resolution in VPC peering:
    - Allow DNS resolution from peer VPC - _different accounts_.
    - Allow DNS resolution from local VPC - _same account_.
    - DNS configuration is in the VPC peering settings.
    - Both VPC need to allow DNS resolution.

### VPC Flow logs
A logging service that captures metadata about IP traffic that flows through an 
entity to which it is attached.

- A flog log entry is a unique communication between two ip addresses.
- Not a packet capturing tool.
- Data captured:
    
    version account-id iface-id src-addr dst-addr srcport dstport prot packets bytes start end action log-status

- Flow logs are attached to ENI's, subnets or VPC's.
- Flow logs capture ingress and egress traffic.
    - It can be configured to log accepted, rejected, or all traffic.
- Once you configure a flow log you cannot change it.
    - You must delete it and recreate it.
- FLow logs have a several minutes of delay(up to 15 min).
- Storage could be cloudwatch or s3.
    - Cloudwatch:
        - IAM role required
        - Log group required
        - Each ENI equals to a log stream.
    - S3:
        - Use default formatting.
        - Produce aggregated logs.

## Domain Name System(DNS)
A globally distributed service that translates domain names to IP addresses.

    blog.bitclvx.com.
    .           root level domain
    .com        top level domain
    .bitclvx    second level domain
    blog        subdomain of second level domain

Name Servers(NS)
Translates domain names to ip addresses. 2 kinds:
- Authoritative: provides answers to queries they know about.
- Non Authoratative: Points to other servers or serves cached content from other 
name server's data.

Zones
Container that holds important information about how to route traffic for domain
names and its subdomains.

DNS Resolution
1. Checks locally: host files, local dns.
2. Forward request to name server.
3. Waits for resolvers to answer query.
    3.1 Resolver resursively resolves query until it find the authoritative 
    server for the domain

Record Types

| Record | Description |
|*|*|
| A and AAA | Maps a host an ip address |
| CNAME(Canonical Name Record) | defines an alias for a host |
| NS(Name Server) | Records direct traffic to the DNS servers that contain the authoritative DNS records|
| MX(Mail Exchange) | Records are used to define mail servers |
| TXT(Text) | Hols text information |
| PTR(Pointer) | Maps an IP address to a dns |
| SOA | Start of authority |
| SPF | Send Policy Framework |
| CAA | Certificate authority authorization |
| Alias | Maps AWS resources |

## Route 53
- Authoritative DNS server.
- Provides direct updates to manage public DNS names.
- Answers DNS queries.
- Translates domain names to aws constructs.

### Hosted Zones
- Collection of record sets that are managed under a single domain name.
- These record sets tell Route 53 how to respond to a DNS query.
2 types of zones:
- Public zones: How to route traffic from the Internet and your domain.
- Private zones: How to route traffic within one or more VPC's. a
    #These settings need to be enabled in the VPC:
    enableDnsHostnames
    enableDnsSupport

## Health Checks
Monitor resources such as web servers or email servers using alerts in cloudwatch.

- If an endpoint fails, Route 53 removes the entry until the endpoint check is healthy.
- Heal checks are not triggered by DNS queries, but are run by AWS periodically.

## Routing Policies
Determine how to respond to queries

- We can set a routing policy whenever we create a record set in Route 53.

| Routing Policy | Purpose |
| * | * |
| Simple | Default Policy |
| Weighted | Percentage route |
| Latency-base | Fastest connection routing |
| Failover | One-or-the-other routing |
| Geolocation | location-based routing |
| Multi-value Response Routing | Responds with multiple records sets for the same query(max 8 records per request) |

### Weighted Routing Policy
- Defines a set id to identify all the records to be weighted.
- Records sets need to have a weight.
- The probabibility of any resource record set being called is determine by:
    
    weight for a specific record set / sum of weights for all record sets

- It also supports health checks.
    - The sum of weights gets recalculated when a record is removed due failing a health check.
- If weight is set to 0, it will not be in the pool of active records.
- If all the records are set to a weight of 0, then traffic is distributed equally 
among all the records.

### Failover Routing Policy
- Each group needs to have their own set id.
- Each record set needs to have health checks.
- If both primary and secondary are unhealthy then the primary is returned, even 
though it is unhealthy.
- If one record set fails the health check, the other will return if it's healthy.

### Geolocation Routing Policy

    default:
      North America:
        Mexico
        US
          California
          Louisiana
      Europe:
        UK
        Spain

- It works from the most specific location to the least specific.
- If a health check is set up and the record set fails, it will use the most 
specific record for that query.
- Not having a default region allow us to lock users to a specific location.
- The IP address is from the dns resolver not the user(unless the user uses its 
own resolver).

## Private Hosted Zones
- Internal linked VPC's to the private hosted zone and resources will resolve
the internal hosted zone.
- Public dns names resolved by linked VPC's from a public hosted zone will resolve 
to the resource public ip address because public dns names will always 
resolve to public ip address.

    TODO DIAGRAMA THIS

### Spli View / Horizon DNS
- A hosted zone which sits in the private and public hosted zones.
    - Private clients will resolve internal IP's.
    - Public clients will resolve public IP's.




