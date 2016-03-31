Networking 
==========
    
    
Implement Packet Filtering 
--------------------------
- `iptables -F|--flush` , flush all rules.
- `iptables -L|--list [table]`, lists all rules or rules per table.
- `iptables -P FORWARD DROP`, changes the chain FORWARD policy to DROP.
- `iptables -A [table] [command] [action]`, adds a rule to a table.
    - e.g.:
        - `iptables -A INPUT --protocol icmp --in-interface eth0 -j DROP`
        - `iptables -A INPUT --protocol icmp --in-interface eth0 -j REJECT`
            - Difference between REJECT and DROP is the former responds with an
            icmp-response packet, the later only drops without response.
        - `iptables -A INPUT -p tcp -s 0/0 --sport 1024:65535 -d 0/0 --dport 80 -j REJECT`
        - `iptables -A OUTPUT -p tcp -s 0/0 --sport 1024:65535 -d 0/0 --dport 80 -j REJECT`
- `iptables-save > /etc/iptables/rules.v4`
- `iptables-restore < /etc/iptables/rules.v4`
    
    
Configure Firewall Settings 
---------------------------
-  NADA VER ITEM ANTERIOR. 
    
Configure Network Services to Start on Boot - systemd 
-----------------------------------------------------
    
- `systemctl status [service].socket`, to know if a network service is running.
- `systemctl enable [service].socket`, enables a network service at startup.
- `systemctl start [service].socket`, starts a network service.
    
Configure Network Services to Start on Boot - sysvinit 
-----------------------------------------------------

- `chkconfig [service] on|off`, to configure service at startup.
- `service start|stop|status [service]`, starts, stops or checks status of a service.
    
    
Monitor Network Performance 
---------------------------
    
- `ss [options] [FILTER]` is used to dump socket statistics.
- `ss -t -a` , shows all tcp port opens listening and not listening.
- `ss -tn dport = port`, shows tcp connections to destination port 23

- `nmap [Scan Type...] [Options] {target specification}` - Network exploration tool and security / port scanner
    - `nmap -A localhost`
    - `nmap -A -sS locahost`   

- `apt install iptraf dstat`

Statically Route IP Traffic 
---------------------------
    
- `route add -net [IP_NETWORK] netmask [NETWORK_MASK] gw [IP_GATEWAY] dev [GATEWAY_IFACE]` 
- ip route add [IP_NETWORK]/[NETMASK] via [IP_GATEWAY] dev [GATEWAY_IFACE]
    
Dynamically Route IP Traffic 
----------------------------
    
- `apt-get install quagga`    
- `vim /etc/quagga/daemons.conf` to activate ripd, or ospfd.
- `echo -e 'service quagga restart\nhostname [hostname]\npassword [password] > /etc/quagga/zebra.conf'`
- `echo -e 'service quagga restart\nhostname [hostname]\npassword [password] > /etc/quagga/ripd.conf'`
- `chown quagga:quaggavty /etc/quagga/*.conf`
    - `nc localhost 2601`, to enter configuration mode for zebra.
    - `nc localhost 2602`, to enter configuration mode for ripd.
