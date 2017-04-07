#!/usr/bin/env bash

set -x

echo "docksal-startup.sh started"

# Constants expected from the instance launch configuration:
# DOCKER_HUB_AUTH
# DOCKER_HUB_EMAIL
# AWS_KEY
# AWS_SECRET
# SB_IP
# PROJECT_INACTIVITY_TIMEOUT
# PROJECT_DANGLING_TIMEOUT

# Copy CI credentials
sudo mkdir /home/ubuntu/.docker
cat <<EOF > /home/ubuntu/.docker/config.json
{
    "auths": {
            "https://index.docker.io/v1/": {
                    "auth": "$DOCKER_HUB_AUTH",
                    "email": "$DOCKER_HUB_EMAIL"
            }
    }
}
EOF
# This has to be done under the ubuntu user to load Docker Hub credentials
sudo su - ubuntu -c 'docker run --rm -v /home/ubuntu:/data ffwagency/us-east-ci'
sudo chown -R ubuntu:ubuntu /home/ubuntu
ssh-keygen -t rsa -N "" -f /home/ubuntu/.ssh/id_rsa
sudo chmod 600 /home/ubuntu/.ssh/id_rsa
sudo rm -rf /home/ubuntu/.git

# Assign a static IP address
aws-ec2-assign-elastic-ip --region us-west-2 --access-key "$AWS_KEY" --secret-key "$AWS_SECRET" --valid-ips "$SB_IP"

# Reset docksal-ssh-agent
# This has to be done under the ubuntu user to load the ssh keys
sudo su - ubuntu -c 'fin reset ssh-agent'
# Reset docksal-vhost-proxy
fin reset proxy

echo "docksal-startup.sh finished"
