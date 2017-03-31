# VLANs

- VLANs provide a logical way to group devices as if they were attached to the same wire.
- VLANs allows to segment networks based on factor such as funciton, project team, or application.
- Any switch port can belong to a VLAN, and unicast, broadcast, and multicast packets are forwarded and flooded only to end stations within the VLAN where the packets are sourced.
- Each VLAN is considered a separate logical network, and packets destined for stations that do not belong to the VLAN must be forwarded through a device that supports routing.
- If a device in one VLAN sends a broadcast Ethernet frame, all devices in the VLAN receive the frame, but devices in other VLANs do not.

## Benefits:
- Improved security.
    * Each VLAN is a different network segment.
- Reduced Cost.
    * More efficient use of existing bandwidth and uplinks.
- Better Performance.
    * Reduces unnecessary traffic(small broadcast domains).
- Smaller Broadcast Domains.
    * Dividing a network into VLANs reduces the number of devices in the broadcast domain.
- IT efficiency.
    * Easier to manage a network because users with similar network requirements share the same VLAN.

## Type of VLANs
- Data VLAN
    * Configured to carry used-generated traffic. 
    * VLAN carrying voice or management traffic WOULD NOT be part of a data VLAN.
- Default VLAN
    * ALL switch ports become part of the default VLAN after initial bootup of a switch loading default configurations.
    * The default VLAN for Cisco switches is VLAN 1.
    * VLAN 1 cannot be renamed or deleted.
- Native VLAN
    * It's assigned to an 802.1Q trunk port. 
        - A 802.1Q trunk port supports traffic coming from many VLANs(tagged traffice), as well as traffic that does not come from a VLAN(untagged traffice).
    * Native VLAN is VLAN 1 by default.
    * [More info](https://supportforums.cisco.com/discussion/11700441/what-difference-between-default-vlan-and-native-vlan)
- Management VLAN
    * Any VLAN configured to access the management capabilities of a switch. 
    * VLAN 1 is the management VLAN by default. 
- Voice VLAN
    * Assured bandwidth to ensure voice quality.
    * Transmission priority over other types of network traffic.
    * Ability to be routed around congested areas on the network.
    * Delay of less than 150ms across the network.

# Trunk
- Point-to-point link between two network devices that carries more than one VLAN.
- VLAN trunks allow all VLAN traffice to propagate between switches, so that devices which are in the same VLAN, but connected to different switches, can communicate without the intervention of a router.
- A VLAN trunk does not belong to a specific VLAN.
- By default, on a Cisco Catalyst Switch, all VLANs are supported on a trunk port.

## Vlan tagging
- Then 802.1Q header includes a 4-byte tag inserted within the origin Ethernet frame header, specifying the VLAN to which the frame belongs.
- When the switch receives a frame on a port configured in access mode assigned a VLAN, the switch inserts a VLAN tag in the frame header, recalculates the FCS, and sends the tagged frame out of a trunk port.
- Dst MAC - Src MAC - TAG - Type/Length - Data - FCS
- VLAN tag Field details:
    * Type: a 2-byte value called the tag protocol ID(TPID)
    * User priority: a 3-bit value that supports level or service implementation.
    * Canonical Format Identifeir(CFI): A 1-bit identifier that enables Token Ring frames to be carried accross Ethernet links.
    * VLAN ID(ID): A 12-bit VLAN identification number which supports up to 4096 VLAN IDs.

## 
