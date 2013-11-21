#!/bin/bash

#Bash loop to read from stdin list of instances.
#useful for when doing queries like

# ec2-describe-tags --filter "resource-type=instance" --filter "key=Owner" --filter "value=Josh*" | cut -f 3


while read INSTANCE; do
	ec2-create-tags $INSTANCE --tag Stop="`date`"
	ec2-stop-instances $INSTANCE
done