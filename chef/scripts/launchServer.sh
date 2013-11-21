#!/bin/bash -x

#For pure amazon:
#AMI=ami-687b4f2d

#For voicemachine based AMI
export AMI=ami-bcad98f9

#If you need an external IP, which you need if you're going to download from the intertubes
export SET_IP="--associate-eip 50.18.219.219"

#if not
#SET_IP=

export RUN_LIST="-r recipe[nexus]"


KNIFE_HOME=~/.chef/ec2 knife ec2 server create -I $AMI -f m1.small  -i ~/.ssh/stage-voice.pem -g sg-4aed0125,sg-bc4e52d0 -S stage-voice --ssh-user ec2-user  -T "Owner=Josh Mahowald,Responsible Party=Josh Mahowald,Name=GCloud Repository" --region us-west-1  --subnet subnet-27f4674e -Z us-west-1a --template-file bootstrap/gen-dev-aws.erb -E dev-aws $SET_IP $RUN_LIST

