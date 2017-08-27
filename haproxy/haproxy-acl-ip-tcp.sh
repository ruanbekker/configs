global
  log         127.0.0.1 local2
  chroot      /var/lib/haproxy
  pidfile     /var/run/haproxy.pid
  maxconn     1020   # See also: ulimit -n
  user        haproxy
  group       haproxy
  daemon

  stats socket /var/lib/haproxy/stats.sock mode 600 level admin
  stats timeout 2m

defaults
  mode    tcp
  log     global
  option  dontlognull
  option  redispatch
  retries                   3
  timeout queue             45s
  timeout connect           5s
  timeout client            1m
  timeout server            1m
  timeout check             10s
  maxconn                   1020

listen stats
  bind    *:80
  mode    http
  stats   enable
  stats   show-legends
  stats   refresh           5s
  stats   uri               /
  stats   realm             Haproxy\ Statistics
  stats   auth              admin:admin
  stats   admin             if TRUE

listen galera-lb
  bind    *:3306
  mode    tcp
  acl     network_allowed src 10.1.10.2 10.2.10.2 192.168.1.10
  tcp-request               content accept if network_allowed
  tcp-request               content reject
  default_backend           galera-cluster

listen mongodb-lb
  bind    *:27017
  mode    tcp
  acl     network_allowed src 10.1.10.2 10.2.10.2 192.168.1.10
  tcp-request               content accept if network_allowed
  tcp-request               content reject
  server  mongodb-master 10.4.113.21:27018

backend galera-cluster
  balance roundrobin
  server  mysql-1 1.2.3.4:3306  check
  server  mysql-2 1.2.3.5:3306  check backup
  server  mysql-3 1.2.3.6:3306  check backup