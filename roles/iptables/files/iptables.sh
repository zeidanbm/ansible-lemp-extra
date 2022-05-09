#!/bin/bash

# Set Default Policy
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# Flush all tables
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
iptables -t raw -F

# Delete user-defined chains
iptables -X

# Allow localhost
iptables -A INPUT -i lo -j ACCEPT

# Allow established and related input
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Block remote packets claiming to be from a loopback address.
iptables -A INPUT -s 127.0.0.0/8 ! -i lo -j DROP

# Drop all packets that are going to broadcast, multicast or anycast address.
iptables -A INPUT -m addrtype --dst-type BROADCAST -j DROP
iptables -A INPUT -m addrtype --dst-type MULTICAST -j DROP
iptables -A INPUT -m addrtype --dst-type ANYCAST -j DROP
iptables -A INPUT -d 224.0.0.0/4 -j DROP

# Chain for preventing ping flooding - up to 6 pings per second from a single
# source, again with log limiting. Also prevents us from ICMP REPLY flooding
# some victim when replying to ICMP ECHO from a spoofed source.
iptables -N ICMPFLOOD
iptables -A ICMPFLOOD -m recent --set --name ICMP --rsource
iptables -A ICMPFLOOD -m recent --update --seconds 1 --hitcount 6 --name ICMP --rsource --rttl -m limit --limit 3/sec --limit-burst 1 -j LOG --log-prefix "iptables[ICMP-flood]: "
iptables -A ICMPFLOOD -m recent --update --seconds 1 --hitcount 6 --name ICMP --rsource --rttl -j DROP
iptables -A ICMPFLOOD -j ACCEPT

# Allow HTTP & HTTPS
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT

# Allow ssh for specific ip, replace ??? with your real ip and comment out the following line and uncomment the next two lines
iptables -A INPUT -p tcp -m tcp --dport 2298 -j ACCEPT
#iptables -A INPUT -p tcp -m tcp --dport 2298 -s ??? -j ACCEPT
#iptables -A INPUT -p tcp --dport 2298 -j DROP

# Allow port 53 for dns queries
iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT

# Permit useful IMCP packet types for IPv4
# Note: RFC 792 states that all hosts MUST respond to ICMP ECHO requests.
# Blocking these can make diagnosing of even simple faults much more tricky.
# Real security lies in locking down and hardening all services, not by hiding.
iptables -A INPUT -p icmp --icmp-type 0  -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 3  -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 11 -m conntrack --ctstate NEW -j ACCEPT

# Permit IMCP echo requests (ping) and use ICMPFLOOD chain for preventing ping
# flooding.
iptables -A INPUT -p icmp --icmp-type 8  -m conntrack --ctstate NEW -j ICMPFLOOD

# Do not log packets that are going to port used by UPnP protocol.
iptables -A INPUT -p udp --dport 1900 -j DROP

# Do not log late replies from nameservers.
iptables -A INPUT -p udp --sport 53 -j DROP

# Good practise is to explicately reject AUTH traffic so that it fails fast.
iptables -A INPUT -p tcp --dport 113 --syn -m conntrack --ctstate NEW -j REJECT --reject-with tcp-reset

# Prevent DOS by filling log files.
iptables -A INPUT -m limit --limit 1/second --limit-burst 100 -j LOG --log-prefix "iptables[DOS]: "