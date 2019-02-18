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

## Storage

**TEST VOLUME LIFECYCLE WITH KUBERNETES AND WITHOUT KUBERNETES**

- Block Storage is provision in units called volumens.

- Volumes function as generic block devices.

- Volumes are an independent resource that can be moved from one Droplet to
another within the same region.

- DigitalOcean's automated backups DO NOT include block storage voluments, but
you can take manual backups with volume snapshots.

- Volumes are region-specific resources. They can be moved freely between Droplets
within the same region.

- Volumes can only be attached to one Droplet at a time.

- Up to 7 volumes can be attached to a single Droplet.

- Volumes are charged at a rate of $0.10 per GB per month.


#### Storage - K8s

- Create and access DigitalOcean block storage volumes by creating a PersistentVolumeClaim
 as part of your deployment.

- If a volume does not exist when creating the PersistentVolumeClaim, one will be created.
If one already exists, then the existing volume will be mounted on the first object.

- Billing for the block storage volume begins when the object is successfully created.

- To end billing, you *MUST* explicitly delete the volume.

- When you’ve deleted a cluster from the control panel, the volume will not be 
automatically deleted and billing will continue. In this case, visit the control 
panel and manually delete the block storage volume.

#### Notes in storage and k8s

Volumes created and attached to the droplet/worker by the Panel **ARE NOT REFLECTED**
in the Kubernetes PersistenVolume list. The only way to create a volume for Kubernetes 
is through the PersistenVolumeClaim Object.

> DO allows to create PV and create a PVC referring that PV. However, the pv's claim
doesn't appear listed in the volumes page.



## Load Balancer

- The DigitalOcean Cloud Controller supports provisioning DigitalOcean Load 
Balancers in a cluster’s resource configuration file.

- A load balancer will be create if it doesn't exist.

- Billing begins once the creation is completed.

- To delete a cluster’s load balancer use kubectl. When this command is successful, 
it both removes the load balancer from the cluster and deletes it from your account.

- When you delete a cluster with a load balancer service from the control panel, 
the load balancer is not automatically deleted. You can remove it using the control 
plane in the Load Balancer section.


