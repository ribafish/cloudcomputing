# Submission of Assignment 1


## 1. AWS budget, 70% Notifier

![](material/budget.png)
*A screenshot showing the budget you created in Amazon AWS that notifies you when you used 70% of your yearly budget.*


## 2. AWS EC2 Setup

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

*TODO: insert command-line listing*

commented command-line listing used to prepare the Amazon EC2 instance

## 3. VM in OpenStack setup

*TODO: inser command-line listing*

commented command-line listing used to prepare and launch the virtual
machine in OpenStack

## 4. Benchmarks

**For every benchmark:**

- A description of your benchmarking methodology, including any written source code or scripts
-  The benchmarking results for the three platforms, including
descriptions and plots
-  Answers to the questions

### Disk benchmarks



Sequential Reads
Sequential Writes
Sequential Reads and Writes
Random Reads
Random Writes
Random Reads and Writes (randrw)

### CPU benchmarks



### Memory benchmarks
