# Used by ifup(8) and ifdown(8). See the interfaces(5) manpage or
# /usr/share/doc/ifupdown/examples for more information.
# The loopback network interface
auto lo
iface lo inet loopback

# Label public
auto eth0
iface eth0 inet static
    address 104.130.6.98
    netmask 255.255.255.0
    gateway 104.130.6.1
#iface eth0 inet6 static
#    address 2001:4802:7802:104:be76:4eff:fe20:ae29
#    netmask 64
#    gateway fe80::def
    dns-nameservers 69.20.0.164 69.20.0.196

# Label private
auto eth1
iface eth1 inet static
    address 10.208.230.144
    netmask 255.255.224.0
    post-up route add -net 10.208.0.0 netmask 255.240.0.0 gw 10.208.224.1 || true
    pre-down route del -net 10.208.0.0 netmask 255.240.0.0 gw 10.208.224.1 || true
    post-up route add -net 10.176.0.0 netmask 255.240.0.0 gw 10.208.224.1 || true
    pre-down route del -net 10.176.0.0 netmask 255.240.0.0 gw 10.208.224.1 || true

# Label glusterfs
auto eth2
iface eth2 inet static
    address 192.168.3.1
    netmask 255.255.255.0

