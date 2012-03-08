# Class: iproute2facts
#
# This module adds a number of additional facts representing the output of /sbin/ip addr show from the iproute2 suite
#
# Parameters:
#
# Actions:
#
# Requires: Package['iproute']
#
# Sample facter output:
# 
# iproute2_addr_eth0_inet6address => fe80::20c:29ff:fec2:5945/64
# iproute2_addr_eth0_inet6broadcast => 
# iproute2_addr_eth0_inet6scope     => link
# iproute2_addr_eth0_inetaddress    => 10.50.5.115/24
# iproute2_addr_eth0_inetbroadcast  => 10.50.5.255
# iproute2_addr_eth0_inetscope      => global eth0
# iproute2_addr_eth0_linkaddress    => 00:0c:29:c2:59:45
# iproute2_addr_eth0_linkbroadcast  => ff:ff:ff:ff:ff:ff
# iproute2_addr_eth0_linktype       => ether
# iproute2_addr_eth0_mtu            => 1500
# iproute2_addr_eth0_preferred_lft  => forever
# iproute2_addr_eth0_qdisc          => pfifo_fast
# iproute2_addr_eth0_qlen           => 1000
# iproute2_addr_eth0_state          => <BROADCAST,MULTICAST,UP,LOWER_UP>
# iproute2_addr_eth0_valid_lft      => forever
# iproute2_addr_lo_inet6address     => ::1/128
# iproute2_addr_lo_inet6broadcast   => 
# iproute2_addr_lo_inet6scope       => host
# iproute2_addr_lo_inetaddress      => 127.0.0.1/8
# iproute2_addr_lo_inetaddress_2    => 1.0.0.1/32
# iproute2_addr_lo_inetbroadcast    => 
# iproute2_addr_lo_inetbroadcast_2  => 
# iproute2_addr_lo_inetscope        => host lo
# iproute2_addr_lo_inetscope_2      => global lo
# iproute2_addr_lo_linkaddress      => 00:00:00:00:00:00
# iproute2_addr_lo_linkbroadcast    => 00:00:00:00:00:00
# iproute2_addr_lo_linktype         => loopback
# iproute2_addr_lo_mtu              => 16436
# iproute2_addr_lo_preferred_lft    => forever
# iproute2_addr_lo_qdisc            => noqueue
# iproute2_addr_lo_state            => <LOOPBACK,UP,LOWER_UP>
# iproute2_addr_lo_valid_lft        => forever
# iproute2_addr_sit0_linkaddress    => 0.0.0.0
# iproute2_addr_sit0_linkbroadcast  => 0.0.0.0
# iproute2_addr_sit0_linktype       => sit
# iproute2_addr_sit0_mtu            => 1480
# iproute2_addr_sit0_qdisc          => noop
# iproute2_addr_sit0_state          => <NOARP>
#
# Cooresponding output of /sbin/ip addr show
# /sbin/ip addr show
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue 
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo
#     inet 1.0.0.1/32 scope global lo
#     inet6 ::1/128 scope host 
#        valid_lft forever preferred_lft forever
# 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
#     link/ether 00:0c:29:c2:59:45 brd ff:ff:ff:ff:ff:ff
#     inet 10.50.5.115/24 brd 10.50.5.255 scope global eth0
#     inet6 fe80::20c:29ff:fec2:5945/64 scope link 
#        valid_lft forever preferred_lft forever
# 3: sit0: <NOARP> mtu 1480 qdisc noop 
#     link/sit 0.0.0.0 brd 0.0.0.0
#
class iproute2facts {
    package {'iproute':
        ensure => present,
    }
}
