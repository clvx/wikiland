# Kubeconfig

### Installing kubectl in Ubuntu

    sudo snap install kubectl --classic

###  Namespaces

Kubernetes uses *namespaces* to organize objects in the cluster. The default
namespace is *default*. You can pass the **--namespace** flag to kubectl.

    #using a different namespace
    kubectl --namespace=myNamespace get pods

### Contexts

If you want to change the default namespace more permanently, you can add your
namespace to a *context*. 

    #Adding namespace to a context
    kubectl config set-context development --namespace=myNamespace
    
    #Remember to use your context
    kubectl config use-context development


### Configuring kubectl

In order for `kubectl` to find and access a kubernetes cluster, it needs a kubeconfig
file. By default `kubectl` configuration is located at `~/.kube/config`.

    #Check kubectl cluster info
    kubectl cluster-info

    #Adding bash autocompletion to bashrc
    echo "source <(kubectl completion bash)" >> ~/.bashrc 

    #Switching context between multiple cluster
    kubectl config use-context [context]    

    #View kubeconfig configuration
    kubectl config view 

    #Review current context configuration
    kubectl config view --minify

    #kubeconfig example for 2 cluster with 2 users and 3 contexts.
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority: /path/to/ca.crt
        server: https://[ipaddr]:[port]
      name: myCluster1
    - cluster:
        certificate-authority: /path/to/ca.crt
        server: https://[ipaddr]:[port]
      name: myCluster2
    contexts:
    - context:
        cluster: myCluster1
        user: myUser1
      name: development
    - context:
        cluster: myCluster1
        user: myUser1
      name: stage
    - context:
        cluster: myCluster2
        user: myUser2
      name: production
    current-context: development
    kind: Config
    preferences: {}
    users:
    - name: myUser1
      user:
        as-user-extra: {}
        client-certificate: /path/to/client.crt
        client-key: /path/to/client.key
    - name: myUser2
      user:
        as-user-extra: {}
        client-certificate: /path/to/client.crt
        client-key: /path/to/client.key

Many of these configurations can be set up using `kubectl config`. More info
`kubectl config -h`.

    #Check kubectl version and cluster API version 
    kubectl version

    #Get a cluster diagnosis. It lists:
    - controller-manager status
    - scheduler status
    - etcd server status: Where all the API objects are stored.
    kubectl get componentstatuses
    
    #List nodes. It will list master and worker nodes.
    kubectl get nodes

### Viewing APi objects

    #Get resource/object information
    kubectl get [resource-name] <object-name>
    
    #Listing as JSON
    kubectl get [resource-name] <object-name> -o jsonpath 
    
    #List detailed information of an object
    kubectl describe [resource-name] <object-name>

### Creating, Updating and Destroyin Kubernetes Objects

Objects in the Kubernetes API are represented as JSON or YAML files. You can use
these YAML, or JSON files to create, update, or delete objects on the Kubernetes
server.

    #Create or update an object
    kubectl apply -f obj.yaml

    #Delete an object 
    kubectl delete -f obj.yaml

    #Deleting an object using the resource type and name:
    kubectl delete [resource-name] <obj-name>

### Labeling and Annotating Objects

Labels and annotations are tags for your objects. Both labels and annotations
have the same syntax.

    #Adding a label
    kubectl label [resource-name] <object-name> key=value

    #Removing a label
    kubectl label [resource-name] <object-name> -key

### Debugging commands

    #Listing the logs of a running pod
    kubectl logs <pod-name>

    #Listing the logs of a running container
    kubectl logs <pod-name> -c <container-name>

    #Accesing a pod
    kubectl exec -it <pod-name> -- bash
