##3. VM in OpenStack setup

###3.1  Configuration

Download and source the OpenStack RC file

```
$ . cc17-group06-openrc.sh
```

Load parameters into the environment

```
$ source openrc
```

###3.2 Import a key pair named 'group06key'

```
$ openstack keypair create --public-key group06key.pub keyPair
ssh passphrase:group06
```

###3.3 Allow SSH to the intances and allow pinging of the instances

```
$ openstack security group rule create default \--protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0
$ openstack security group rule create --protocol icmp \ default
```

###3.4 Launch an instance

```
$ openstack server create --flavor 604de11c-3222-4902-8523-11cc61b5b485 --image 11f6b8aa-31df-4b66-8b42-5ee9760c47ba --key-name group06key --security-group default proj1
```

### 3.5 Assign a floating IP to the instance

```
$ openstack server add floating ip proj1 10.12.1.215
```

### 3.6 Log in via ssh

```
$ ssh -i group06key.key ubuntu@10.200.2.117
```

### 3.7 Set up VM with needed tools

```
$ sudo apt-get update
$ sudo apt install yum
$ sudo yum install libaio-devel
$ sudo apt-get install fio
$ sudo apt-get install gcc
```

### 3.8 Run benchmarks

```
$ ./linpack.sh
$ ./memsweep.sh
$ ./perform_tests.sh 
Performing CPU Benchmark ...
Performing Memory Benchmark ...
Performing Disk Benchmark ...
  - seq read
  - seq write
  - seq read & write
  - rand read
  - rand write
  - rand read & write
```

### 