# Set a static IP to a debian server

This is useful after or before you installed YaCy on a debian server to get a unique handle to the YaCy peer in your network. We recommend to use the default address 192.168.1.70 to standardize the access to YaCy 'Appliance' Servers.

To define a static IP in your debian installation, do

* edit `/etc/network/interfaces`
* replace the line
```
iface eth0 inet dhcp
```
with
```
iface eth0 inet static
  address 192.168.1.70
  netmask 255.255.255.0
  gateway 192.168.1.1
```

If your router is at address `192.168.1.1` - otherwise replace `192.168.1.1` with the address of your router. If you want to use a different address than `192.168.1.70` for your YaCy peer, then replace `192.168.1.70` with your wanted address.

If you installed YaCy with the default port 9080, then your YaCy peer will be available at http://192.168.1.70:8090

## Special Setting on Ubuntu

If you are running Ubuntu, then the NetworkManager will ignore these settings until you replace the line "managed=false" with "managed=true" in /etc/NetworkManager/NetworkManager.conf

## Set DHCP and a static IP when running debian in VirtualBox

If you are running debian on a VirtualBox, then you can easily have two network interfaces. One of the interfaces can be configured as dhcp connection (over a virtual NAT) to ensure that you will always have a internet connection within your virtual machine while you can also have a second connection which makes it possible to reach your VM with an IP within your intranet (or from the console where you are running the VM).

* in the VirtualBox manager, open the network configuration and set Adapter 1 to NAT
* set Adapter 2 to Bridge with name: en1
* in /etc/network/interfaces, set the configuration to:

```
auto lo
iface lo inet loopback

allow-hotplug eth0
iface eth0 inet dhcp

allow-hotplug eth1
iface eth1 inet static
  address 192.168.1.70
  netmask 255.255.255.0
  gateway 192.168.1.1
```

This will enable access to the VM at port 192.168.1.70. Please replace this IP to the value you want.