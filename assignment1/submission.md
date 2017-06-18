# Submission of Assignment 1


## 1. AWS budget, 70% Notifier

![](material/budget.png)
*A screenshot showing the budget you created in Amazon AWS that notifies you when you used 70% of your yearly budget.*


## 2. AWS EC2 Setup

### 2.1. Configure AWS CLI
```
$ aws configure

AWS Access Key ID [****************4237]:
AWS Secret Access Key [****************Y1mr]:
Default region name [eu-central-1]:
Default output format [None]:
```

### 2.2. Create key pair

```
$ aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath MyK
eyPair.pem
```

### 2.3. Create security group

```
$ aws ec2 create-security-group --group-name MySg --description "CCSG"
{
    "GroupId": "sg-0eee8465"
}

```

### 2.4. Add SSH rule to security group

This will allow SSH traffic from any IP.

```
$ aws ec2 authorize-security-group-ingress --group-name MySg --protocol tcp --port 22 --cidr 0.0.0.0/0

```

### 2.5. Check the image if it follows requirements

```
$ aws ec2 describe-images --image-ids ami-f52bfa9a
{
    "Images": [
        {
            "VirtualizationType": "paravirtual",
            "Name": "amzn-ami-minimal-pv-2017.03.rc-1.20170327-x86_64-s3",
            "Hypervisor": "xen",
            "ImageOwnerAlias": "amazon",
            "ImageId": "ami-f52bfa9a",
            "RootDeviceType": "instance-store",
            "State": "available",
            "BlockDeviceMappings": [],
            "Architecture": "x86_64",
            "ImageLocation": "amzn-ami-eu-central-1/20c6c7a2f174acd6c46f6741dcb762a1a1140f1b7d1584414516094b27a5b889/137112412989/amzn-ami-minimal-pv-2017.03.rc-1.20170327-x86_64.ext4.10g.manifest.xml",
            "KernelId": "aki-931fe3fc",
            "OwnerId": "137112412989",
            "CreationDate": "2017-03-28T01:50:15.000Z",
            "Public": true,
            "ImageType": "machine",
            "Description": "Amazon Linux AMI 2017.03.rc-1.20170327 x86_64 Minimal PV S3"
        }
    ]
}
```

It does, so we can create the instance

### 2.6. Create and run the instance

```
$ aws ec2 run-instances --image-id ami-f52bfa9a --count 1  --instance-type m3.medium --key-name MyKeyPair --security-groups MySg
```

### 2.7. SSH into instance: 

* default user on Amazon AMI insatnces is `ec2-user`
* to get the IP address of the instance, run `aws ec2 describe-instances` command and copy the value under `PublicDnsName` - you can also add `| grep "PublicDnsName"` to get just the public IP

```
$ aws ec2 describe-instances --instance-ids  i-0f7869d58c8c6b8f2 | grep "PublicDnsName"
                                        "PublicDnsName": "ec2-52-59-152-59.eu-central-1.compute.amazonaws.com",
                                "PublicDnsName": "ec2-52-59-152-59.eu-central-1.compute.amazonaws.com",
                    "PublicDnsName": "ec2-52-59-152-59.eu-central-1.compute.amazonaws.com",
```

```
$ ssh -i MyKeyPair.pem ec2-user@ec2-52-59-152-59.eu-central-1.compute.amazonaws.com
The authenticity of host 'ec2-52-59-152-59.eu-central-1.compute.amazonaws.com (52.59.152.59)' can't be established.
ECDSA key fingerprint is SHA256:qUd2NfLrtvUZYlFW2uSUzoGsxZE+gaXhVC6Na+13eKc.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-52-59-152-59.eu-central-1.compute.amazonaws.com,52.59.152.59' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2017.03-release-notes/

```
### 2.8. Set up instance with needed tools

```
$ sudo yum update -y && sudo yum install -y gcc fio git vim aws-apitools-ec aws-amitools-ec2 openssh-clients
```

* Also, clone our repository which holds the benchmark scripts

```
$ git clone https://github.com/ribafish/cloudcomputing.git
```

### 2.9. Run benchmarks (multiple times)

```
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

### 2.10. Terminate instance

```
aws ec2 terminate-instances --instance-ids i-0f7869d58c8c6b8f2
{
    "TerminatingInstances": [
        {
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            },
            "InstanceId": "i-00aa2dd827fd6af2f",
            "CurrentState": {
                "Code": 32,
                "Name": "shutting-down"
            }
        }
    ]
}
```

**TODO: add come comments on commands where needed**

## 3. VM in OpenStack setup

**TODO: inser command-line listing**

commented command-line listing used to prepare and launch the virtual
machine in OpenStack

## 4. Benchmarks

**For every benchmark:**

- A description of your benchmarking methodology, including any written source code or scripts
-  The benchmarking results for the three platforms, including
descriptions and plots
-  Answers to the questions

### Disk benchmarks

1. Look at the disk measurements. Are they consistent with your expectations. If
not, what could be the reason?
2. Based on the comparison with the measurements on your local hard drive,
what kind of storage solutions do you think the two clouds use?


Sequential Reads
Sequential Writes
Sequential Reads and Writes
Random Reads
Random Writes
Random Reads and Writes (randrw)

### CPU benchmarks

1. Look at linpack.sh and linpack.c and shortly describe how the benchmark
works.
2. Find out what the LINPACK benchmark measures (try Google). Would you
expect paravirtualization to affect the LINPACK benchmark? Why?
3. Look at your LINPACK measurements. Are they consistent with your
expectations? If not, what could be the reason? 



### Memory benchmarks

1. Find out how the memsweep benchmark works by looking at the shell script
and the C code. Would you expect virtualization to affect the memsweep
benchmark? Why?
2. Look at your memsweep measurements. Are they consistent with your
expectations. If not, what could be the reason?
