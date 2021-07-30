#!/bin/bash -xe
## UserData log output ##
exec > >(tee /var/log/user-data-launch.log|logger -t user-data -s 2>/dev/console) 2>&1

ALLOC_ID=${eip_alloc_id}

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/.$//')

aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id $ALLOC_ID --region=$REGION
STATUS=$?
if [ 0 = $STATUS ]; then
  exit 0
fi

exit 1
