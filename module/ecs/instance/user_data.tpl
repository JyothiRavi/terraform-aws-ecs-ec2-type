#!/bin/bash

# Update all packages Amazon Linux 2

sudo yum update -y
sudo amazon-linux-extras install ecs
sudo service docker start
sudo systemctl enable --now --no-block ecs.service

#Adding cluster name in ecs config
echo ECS_CLUSTER=sample-cluster-dev-cluster >> /etc/ecs/ecs.config
cat /etc/ecs/ecs.config | grep "ECS_CLUSTER"
sudo ecs start
