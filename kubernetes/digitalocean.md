# Digital Ocean

### K8s

- Kubernetes 1---\* node pools.

- Each node pool can have a different configuration.

- Worker -> Droplet without ssh access.

- DigitalOcean BlockStorage for persisten volumes.

- DigitalOcean Load Balancers to manage incoming traffic.

- Pricing: Priced by the number and capacity of the worker nodes.

- Availability: K8s is available in all regions.

Features:

- Clusters are part of a VPC meaning network communication is private within
the cluster.

- Private networking isolates communication at the account or team level between
Droplets located in the same datacenter.

- DigitalOcean Load Balancers will connect to backend Droplets over the private
network if it is enabled on the Droplets when they are added to the load balancer.

-  Cluster networking is preconfigured with Flannel.

- All of the worker nodes within a node pool have identical resources.

- You can add and remove worker nodes from node pools at any time, and you can
also create additional node pools at any time.

- Kubernetes role-based access control (RBAC) is enabled by default.

- The IP address for a cluster may change. Use the DNS entry in the cluster
config file to set up load balancers and otherwise interact with a cluster.

> The certificate authority, client certificate, and client key data in the
kubeconfig.yaml file are rotated weekly. If you run into errors like the server
doesn't have a resource type "<resource>", Unauthorized, or Unknown resource
type: nodes, try downloading a new cluster configuration file. The certificates
will be valid for one week from the time of the download.

### Storage

**TEST VOLUME LIFECYCLE WITH KUBERNETES AND WITHOUT KUBERNETES**

- Block Storage is prpovision in units called volumens.

- Volumes function as generic block devices.

- Volumes are an independent resource that can be moved from one Droplet to
another within the same region.

- DigitalOcean's automated backups DO NOT include block storage voluments, but
you can take manual backups with volume snapshots.

- Volumes are region-specific resources. They can be moved freely between Droplets
within the same region.

- Volumes can only be attached to one Droplet at a time.

- Up to 7 volumes can be attached to a single Droplet.
