#!/bin/bash

yum update -y
yum install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

chmod 777 /var/run/docker.sock

docker pull preetchauhan/library-frontend:latest
docker run -d -p 80:80 --name frontend preetchauhan/library-frontend:latest