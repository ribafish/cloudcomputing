# Task 2: Introducing Heat

## Prerequisites

- access to CIT Cloud (see previous assignment)
- open VPN connection to TU


## Creation script

In order to keep cli commands short we put the openstack cli command in a shell script - `create-stack.sh`:

```
openstack stack create -t material/server.yml assignment2-task2-stack \
--parameter "name=assignment2-task2-vm" \
--parameter "key_pair=group06key" \
--parameter "flavor=Cloud Computing" \
--parameter "image=ubuntu-16.04" \
--parameter "zone=Cloud Computing 2017" \
--parameter "network=cc17-net"
```

## Executing the heat client script

Just run: 

```
./create-stack.sh
```

## Test if successful

### Assign floating IP address

```
openstack server add floating ip assignment2-task2-vm 10.200.2.251
```

### SSH into instance

```
ssh -i ~/.ssh/open_stack ubuntu@10.200.2.251
```

where `~/.ssh/open_stack` is the private key of the assigned key pair

### From the instance check internet connectivity with ping

```
ping google.de
```

Output:

```
PING google.de (172.217.17.131) 56(84) bytes of data.
64 bytes from ams15s30-in-f131.1e100.net (172.217.17.131): icmp_seq=1 ttl=56 time=15.6 ms
^C
--- google.de ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 15.633/15.633/15.633/0.000 ms
```

"1 packets transmitted" - Indicating we can reach googles server.

## Delete Stack

Delete stack via CLI:

```
openstack stack delete assignment2-task2-stack -y
```

Check deleted instances:

```
openstack stack list --deleted --property "name=assignment2-task2-stack" -c "Stack Name" -c "Stack Status"
```

Output:

```
+-------------------------+-----------------+
| Stack Name              | Stack Status    |
+-------------------------+-----------------+
| assignment2-task2-stack | DELETE_COMPLETE |
+-------------------------+-----------------+
```

