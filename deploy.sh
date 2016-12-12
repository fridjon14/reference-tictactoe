#!/bin/bash


scp -o StrictHostKeyChecking=no -i "/var/lib/jenkins/Keeper.pem" /var/lib/jenkins/workspace/Commit-Stage/.env ec2-user@ec2-35-165-33-243.us-west-2.compute.amazonaws.com:.env
scp -o StrictHostKeyChecking=no -i "/var/lib/jenkins/Keeper.pem" /var/lib/jenkins/workspace/Commit-Stage/docker-compose.yml ec2-user@ec2-35-165-33-243.us-west-2.compute.amazonaws.com:docker-compose.yml
ssh -o StrictHostKeyChecking=no -i "/var/lib/jenkins/Keeper.pem" ec2-user@ec2-35-165-33-243.us-west-2.compute.amazonaws.com "docker-compose up"
