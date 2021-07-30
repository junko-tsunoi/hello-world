#!/bin/bash -xe

## UserData log output ##
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
date
## Common ##
yum -y update

# History format

cat <<EOF> /etc/profile.d/history.sh
# history initialization

HISTTIMEFORMAT='%F %T '
HISTCONTROL=ignoreboth
EOF
sed -i -e 's/HISTSIZE=1000/HISTSIZE=100000/' /etc/profile

## AWS CodeDeploy ##
yum install -y ruby
cd /home/ec2-user
curl -O https://aws-codedeploy-ap-northeast-1.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto

## SSM Agent ##
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

## CloudWatch Agent ##
yum install -y amazon-cloudwatch-agent
