# ssh config

SSH Config helps out a lot

## Basic Config

This is a basic config that I generally use

```
# Globals
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ServerAliveInterval 60
    ServerAliveCountMax 30
    
# Version Control
Host git-codecommit.*.amazonaws.com
    User ABCDEFGHIJKLMNOPQRS
    IdentityFile ~/.ssh/aws
    
Host git.192.168.0.*.nip.io
    User git
    Port 2497
    IdentityFile ~/.ssh/homelab
    
Host github.com
    User git
    IdentityFile ~/.ssh/github
    
# Bastions
Host jumpbox
    Hostname bastion.mydomain.com
    Port 2714
    IdentityFile ~/.ssh/bastion
    
# Host that uses the bastion as ProxyJump
Host myserver
    Hostname 172.19.2.45
    User ruan
    IdentityFile ~/.ssh/id_rsa
    ProxyJump jumpbox
```
