# Helm 

Helm and Tiller are designed to install, remove, and modify logical applications
that can contain many services interacting together.

## Tiller

    #Initailize Tiller

    #It runs inside the kubernetes cluster. 
    #Helm's server portion.
    helm init

    #Verify Tiller installation
    kubectl get pods --namespace kube-system

    #Upgrade Tiller's version
    helm init --upgrade
    #Deleting Tiller
    helm reset
    #or
    kubectl delete deployment tiller-deploy --namespace kube-system

    #Shows helm's client and server version.
    helm version

    #The rules for version numbers are as follows:
    #- Pre-release versions are incompatible with everything else. Alpha.1 is incompatible with Alpha.2.
    #- Patch revisions are compatible: 1.2.3 is compatible with 1.2.4
    #- Minor revisions are not compatible: 1.2.0 is not compatible with 1.3.0, though we may relax this constraint in the future.
    #- Major revisions are not compatible: 1.0.0 is not compatible with 2.0.0.

1. Tiller can be installed into any namespace. By default, it is installed into kube-system.
You can run multiple Tillers provided they each run in their own namespace.
2. Release names are unique **per Tiller instance**.
3. Charts should only contain resources that exist in a single namespace.
4. It is not recommended to have multiple Tillers configured to manage resources 
in the same namespaces. 
5. Limiting Tiller to only be able to install into specific namespaces and/or 
resource types is controlled by Kubernetes RBAC roles and rolebindings. You can 
add a service account to Tiller when configuring Helm via `helm init --service-account <NAME>`

## Using Helm

### Concepts:

- A *Chart* is a helm package. It containers all of the resource definitions 
necessary to run an application, tool, or service inside of a Kubernetes cluster.
- A *Repository* is the place where charts can be collected and shared.
- A *Release* is an instance of a chart running in a Kubernetes cluster. One Chart
can be installed many times into the same Cluster. And each time is installed, a 
new release is created. 

> Helm install **charts** into Kubernetes, creating a new **release** for each 
installation. And to find new charts, you can search Helm chart **repositories**.

    #To obtain details about a command.
    help [command] -h


### Installation

    #Search for a package
    helm search [package]

    #Whenever you install a chart a new release is created.
    #One chart can be installed multiple times into the same cluster.
    #Each relase can be upgraded independently.
    helm install [path_to_project|chart_name]
    helm install --name [release-name] [path_to_project|chart_name]
    helm install [chart.tgz]
    helm install [url] 

    #To know the release status
    helm status [release-name]

    #Inspecting values
    helm inspect values [chart_name]

    #Inspects package configuration files.
    helm inspect [package] 

#### Customizing charts before installation

There are two ways to pass configuration data during install:

- `--values` or `-f`: Specify a YAML file with overrides. This can be specified
multiple times and the righmost file will take precedence.
- `--set`: Specify overrides on the command line.

If both are used, `--set` values are merged into `--values` with higher precedence. 
Overrides specified with `--set` are persisted in a configmap. Values that have 
been `--set` can be viewed for a given release with `helm get values <release-name>`.
Values that have been `--set` can be cleared by running `helm upgrade` with 
`--reset-values` specified.

The `--set` option takes *zero* or *more* name/value pairs. 
    
    --set name=value
    name: value

    --set a=b,c=d
    a: b
    c: d

    --set outer.inner=value
    outer:
        inner: value

    --set name={a, b, c}
    name:
        - a
        - b
        - c
    
    --set nodeSelector."kubernetes\.io/role"=master
    nodeSelector:
        kubernetes.io/role: master
    #config.yaml has all the new values.
    helm install -f config.yaml [char_name]

### Upgrading Charts

- An upgrade taks an existing release and upgrades it according to the information 
you provide. 
- Helm tries to perform the least invasive upgrade. 
- It will only update things that have changed since the last release.
- Every time an install, upgrade, or rollback happens, the revision unmber is 
incremented by 1. The first revision number is always 1. 

    #List deployed releases
    helm ls
    #Upgrade the release
    helm upgrade --set name=value [release_name] [path_to_project|chart_name]
    #Get current release values
    helm get values [release_name]
    #Rollback a release
    helm rollback [release_name] [release_version]
    #Check release history
    helm history [release_name]
    
### Delete a release

- Helm always keeps records of what releases happened. 
- Because Helm keeps records of deleted releases, a release name cannot be re-used.
- If you **really** need to re-use a release name, you can use the `--replace` falg, 
but it will simply reuse the existing release and replace the resource.
- Because releases are preserved in this way, you can rollback a deleted resource, or 
have it re-activated.

    #Deletes a release
    helm delete [release_name]
    #List deleted releases
    helm list --deleted
    #Deleting the record of a release
    helm delete --purge

### Working with repositories.

    #To list which repositories are configured
    helm repo list

    #Add a new repo
    helm repo add <repo_name> [repo_url]

    #Updating helm repo list
    helm repo update

### Creating your own charts

Charts that are archived can be loaded into chart repositories.

    #Creating an empty chart structure
    helm create [chart_name]
    $tree /path/to/chart
    ├── charts
    ├── Chart.yaml
    ├── templates
    │   ├── deployment.yaml
    │   ├── _helpers.tpl
    │   ├── ingress.yaml
    │   ├── NOTES.txt
    │   └── service.yaml
    └── values.yaml

    #Validate lint
    helm lint

    #Package chart
    helm package [chart_name]

### Securing Helm

By default Helm applies **no security configurations** which is appropiate for 
development environments, but not for production. 

1. Create a cluster with RBAC enabled. Even if an identity is hijacked, the identity
has only so many permissions to a controlled space. When Tiller is running inside
of a cluster, it operates with the permissions of its service account. If no
service account name is supplied to Tiller, it runs with the default service 
account for that namespace. This means that all Tiller operations on that server
are executed using the Tiller pod's credentials and permissions.

- Install one Tiller per user, team, or other organizational entity with the 
`--service-account` flag, Roles and RoleBindings.

2. Configure Tiller gRPC endpoint to use a separate TLS certificate. In the default
installation the gRPC endpoint that Tiller offers is available inside the cluster 
without authentication configuration applied. Any process in the cluster can use
the gRPC endpoint to perform operations inside the cluster. To limit Tiller's 
access, TLS configuration allows only authenticated clients. Doing so enables 
any number of Tiller instances to be deployed in any number of namespaces and 
yet no unauthenticated usage of any gRPC endpoint is possible.

- Use the `--tiller-tls-verify` option with `helm init` and the `--tls` flag
with other Helm commands to enforce verification.

3. Release information should be a Kubernetes Secret.

### Using TLS

The Tiller authentication model uses client-side SSL certificates. Tiller itself
verifies there certificates using a certificate authority. Likewise, the client
also verifies Tiller's identity by certifciate authority.

    #Genereting a certificate authority
    openssl genrsa -out ./ca.key.pem 4096
    openssl req -key ca.key.pem -new -x509 -days 7300 -sha256 -out ca.cert.pem -extensions v3_ca

    #Tiller
    #Generating key 
    openssl genrsa -out ./tiller.key.pem 4096    
    #Generating a CSR
    openssl req -key tiller.key.pem -new -sha256 -out tiller.csr.pem
    #Generating certificate
    openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in tiller.csr.pem -out tiller.cert.pem -days 365

    #Helm
    #For production you should create one certificate per user
    #Generate key
    openssl genrsa -out ./helm.key.pem 4096
    #Generating a CSR
    openssl req -key helm.key.pem -new -sha256 -out helm.csr.pem
    #Generating certificate
    openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in helm.csr.pem -out helm.cert.pem  -days 365 

    #Configuring Tiller with TLS
    helm init --tiller-tls --tiller-tls-cert ./tiller.cert.pem --tiller-tls-key ./tiller.key.pem --tiller-tls-verify --tls-ca-cert ca.cert.pem

    #Configuring Helm with TLS
    helm ls --tls --tls-ca-cert ca.cert.pem --tls-cert helm.cert.pem --tls-key helm.key.pem

    #Moving certificates to helm home directory
    cp ca.cert.pem $(helm home)/ca.pem
    cp helm.cert.pem $(helm home)/cert.pem
    cp helm.key.pem $(helm home)/key.pem

    #Calling helm after moving certificates.
    helm ls --tls

