Virtualization
==============

Configure a Hypervisor to Host Virtual Guests 
----------------------------------------------------------
   
- `egrep -c '(vmx|svm)' /proc/cpuinfo`, if returns something besides 0, then 
virtualization is supported.
- `apt-get install qemu-kvm qemu libvirt-bin virtinst bridge-utils virt-manager virt-viewer`
- `lsmod | grep vhost`, checks if vhost networking module is on.
    - `modprobe vhost_net`, enables vhost networking module.

Configure Virtual Networking to Support Virtualized Guests 
----------------------------------------------------------
   
```
cat << EOF > /etc/network/interfaces
auto lo
iface lo net loopback 
Bridging 
autho eth0 
iface br0 inet static
address [ip_address]
network [ip_network]
netmask [network_netmask]
broadcast [ip_broadcast]
gateway [ip_gateway]
bridge_ports eth0
bridge_stp off
auto br0
EOF
```

- `sudo virt-manager`, to install and configure a vm.
   
Install Linux Systems as Virtual Guests 
---------------------------------------
   
NADA INTERESANTE
   
Start, Stop and Modify the Status of a Virtual Machine / Access a VM Console / Configure Systems to Launch At Boot Time - GUI 
-----------------------------------------------------------------------------------------------------------------------------
   
- Se puede hacer autostart desde la vista de booting de la consola de la vm.
   
Start, Stop and Modify the Status of a Virtual Machine / Access a VM Console / Configure Systems to Launch At Boot Time - CLI 
-----------------------------------------------------------------------------------------------------------------------------
   
- `sudo virt-manager &`, starts graphical virt manager.
- `virsh start [vm_name]`, starts a vm.
- `virsh shutdown [vm_name]`, stops a vm.
- `virsh destroy [vm_name]`, destroys a vm.
- `virsh autostart [vm_name]`,  autostarts a vm.
- `virsh list`, lists all vm.
- `virt-viewer [vm_name]`, connects to vm_name console.
   
Resize RAM or Storage of Virtual Machine / Evaluate Virtual Machine Memory Usage 
--------------------------------------------------------------------------------
   
- `ps aux | grep libvirt | grep [vm_name]` 
- `top -p[vm_name_pid]`
   
