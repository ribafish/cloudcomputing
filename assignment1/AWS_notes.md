# AWS

Helpful links: 

* [CLI reference](http://docs.aws.amazon.com/cli/latest/reference/)

## 1. Configuration ##

## Make the budget

![budget](budget.png)

### Configure AWS CLI
```
aws configure

AWS Access Key ID [****************4237]:
AWS Secret Access Key [****************Y1mr]:
Default region name [eu-central-1]:
Default output format [None]:
```

### Create key pair

```
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath MyK
eyPair.pem
```

### Create security group

```
aws ec2 create-security-group --group-name MySg --description "CCSG"
{
    "GroupId": "sg-0eee8465"
}

```

### Add SSH rule to security group

This will allow SSH traffic from any IP.

```
aws ec2 authorize-security-group-ingress --group-name MySg --protocol tcp --port 22 --cidr 0.0.0.0/0

```

## 2. Create the instance

Check the image if it follows requirements
```
aws ec2 describe-images --image-ids ami-f52bfa9a
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

## cmd on local
 
```
$ aws ec2 run-instances --image-id ami-f52bfa9a --count 1  --instance-type m3.medium --key-name MyKeyPair --security-groups MySg
{
    "ReservationId": "r-08f4e97775a98b172",
    "OwnerId": "449655044237",
    "Instances": [
        {
            "ImageId": "ami-f52bfa9a",
            "KernelId": "aki-931fe3fc",
            "BlockDeviceMappings": [],
            "SubnetId": "subnet-79027203",
            "AmiLaunchIndex": 0,
            "RootDeviceType": "instance-store",
            "InstanceId": "i-0f7869d58c8c6b8f2",
            "Hypervisor": "xen",
            "StateTransitionReason": "",
            "PrivateDnsName": "ip-172-31-42-186.eu-central-1.compute.internal",
            "EbsOptimized": false,
            "VirtualizationType": "paravirtual",
            "KeyName": "MyKeyPair",
            "NetworkInterfaces": [
                {
                    "OwnerId": "449655044237",
                    "SubnetId": "subnet-79027203",
                    "Attachment": {
                        "Status": "attaching",
                        "DeviceIndex": 0,
                        "DeleteOnTermination": true,
                        "AttachmentId": "eni-attach-43437f23",
                        "AttachTime": "2017-06-13T20:26:03.000Z"
                    },
                    "PrivateDnsName": "ip-172-31-42-186.eu-central-1.compute.internal",
                    "VpcId": "vpc-42a8c62a",
                    "PrivateIpAddress": "172.31.42.186",
                    "PrivateIpAddresses": [
                        {
                            "PrivateIpAddress": "172.31.42.186",
                            "Primary": true,
                            "PrivateDnsName": "ip-172-31-42-186.eu-central-1.compute.internal"
                        }
                    ],
                    "NetworkInterfaceId": "eni-38ff5549",
                    "MacAddress": "06:21:f5:18:bc:a3",
                    "Groups": [
                        {
                            "GroupId": "sg-0eee8465",
                            "GroupName": "MySg"
                        }
                    ],
                    "Status": "in-use",
                    "SourceDestCheck": true,
                    "Description": ""
                }
            ],
            "PrivateIpAddress": "172.31.42.186",
            "ClientToken": "",
            "ProductCodes": [],
            "State": {
                "Name": "pending",
                "Code": 0
            },
            "SourceDestCheck": true,
            "StateReason": {
                "Message": "pending",
                "Code": "pending"
            },
            "InstanceType": "m3.medium",
            "VpcId": "vpc-42a8c62a",
            "SecurityGroups": [
                {
                    "GroupId": "sg-0eee8465",
                    "GroupName": "MySg"
                }
            ],
            "PublicDnsName": "",
            "Architecture": "x86_64",
            "Placement": {
                "GroupName": "",
                "AvailabilityZone": "eu-central-1b",
                "Tenancy": "default"
            },
            "LaunchTime": "2017-06-13T20:26:03.000Z",
            "Monitoring": {
                "State": "disabled"
            }
        }
    ],
    "Groups": []
}

```

```
$ aws ec2 describe-instances --instance-id i-0f7869d58c8c6b8f2
{
    "Reservations": [
        {
            "ReservationId": "r-08f4e97775a98b172",
            "OwnerId": "449655044237",
            "Groups": [],
            "Instances": [
                {
                    "ProductCodes": [],
                    "ImageId": "ami-f52bfa9a",
                    "Placement": {
                        "Tenancy": "default",
                        "GroupName": "",
                        "AvailabilityZone": "eu-central-1b"
                    },
                    "PublicDnsName": "ec2-52-59-152-59.eu-central-1.compute.amazonaws.com",
                    "PrivateIpAddress": "172.31.42.186",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "Hypervisor": "xen",
                    "BlockDeviceMappings": [],
                    "StateTransitionReason": "",
                    "KernelId": "aki-931fe3fc",
                    "VirtualizationType": "paravirtual",
                    "NetworkInterfaces": [
                        {
                            "NetworkInterfaceId": "eni-38ff5549",
                            "SourceDestCheck": true,
                            "VpcId": "vpc-42a8c62a",
                            "PrivateIpAddresses": [
                                {
                                    "PrivateIpAddress": "172.31.42.186",
                                    "Association": {
                                        "PublicIp": "52.59.152.59",
                                        "IpOwnerId": "amazon",
                                        "PublicDnsName": "ec2-52-59-152-59.eu-central-1.compute.amazonaws.com"
                                    },
                                    "Primary": true,
                                    "PrivateDnsName": "ip-172-31-42-186.eu-central-1.compute.internal"
                                }
                            ],
                            "Attachment": {
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "DeleteOnTermination": true,
                                "AttachmentId": "eni-attach-43437f23",
                                "AttachTime": "2017-06-13T20:26:03.000Z"
                            },
                            "Association": {
                                "PublicIp": "52.59.152.59",
                                "IpOwnerId": "amazon",
                                "PublicDnsName": "ec2-52-59-152-59.eu-central-1.compute.amazonaws.com"
                            },
                            "Status": "in-use",
                            "MacAddress": "06:21:f5:18:bc:a3",
                            "Groups": [
                                {
                                    "GroupId": "sg-0eee8465",
                                    "GroupName": "MySg"
                                }
                            ],
                            "Description": "",
                            "PrivateIpAddress": "172.31.42.186",
                            "OwnerId": "449655044237",
                            "SubnetId": "subnet-79027203",
                            "PrivateDnsName": "ip-172-31-42-186.eu-central-1.compute.internal"
                        }
                    ],
                    "ClientToken": "",
                    "SubnetId": "subnet-79027203",
                    "LaunchTime": "2017-06-13T20:26:03.000Z",
                    "PrivateDnsName": "ip-172-31-42-186.eu-central-1.compute.internal",
                    "SourceDestCheck": true,
                    "AmiLaunchIndex": 0,
                    "VpcId": "vpc-42a8c62a",
                    "SecurityGroups": [
                        {
                            "GroupId": "sg-0eee8465",
                            "GroupName": "MySg"
                        }
                    ],
                    "Architecture": "x86_64",
                    "RootDeviceType": "instance-store",
                    "PublicIpAddress": "52.59.152.59",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "KeyName": "MyKeyPair",
                    "EbsOptimized": false,
                    "InstanceType": "m3.medium",
                    "InstanceId": "i-0f7869d58c8c6b8f2"
                }
            ]
        }
    ]
}
```

### SSH into instance: 

* default user on Amazon AMI insatnces is `ec2-user`
* to get the IP address of the instance, run `aws ec2 describe-instances` command and copy the value under `PublicDnsName` - you can also add `| grep "PublicDnsName"` to get just the public IP

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

copy stuff:

```
$ scp -i /mnt/data/Dropbox/FAKS/Erasmus/CloudComputing/MyKeyPair.pem /mnt/data/Dropbox/FAKS/Erasmus/CloudComputing/github/assignment1/benchmarks/localmachine/perform_tests.sh ec2-user@ec2-52-59-152-59.eu-central-1.compute.amazonaws.com:~
```

##cmd on instance for setup

```
sudo yum update
sudo yum install -y gcc
sudo yum install -y fio
sudo yum install -y aws-apitools-ec2
sudo yum install -y aws-amitools-ec2
sudo yum install -y git
sudo yum install -y vim
git clone https://github.com/ribafish/cloudcomputing.git
```

* needed for scp

```
sudo yum -y install openssh-clients
```

* dd wont install

```
sudo yum install -y dd
Loaded plugins: priorities, update-motd, upgrade-helper
No package dd available.
Error: Nothing to do

```

* all the initial instalations on one line:
```
sudo yum update -y && sudo yum install -y gcc fio git vim aws-apitools-ec aws-amitools-ec2 openssh-clients
```


