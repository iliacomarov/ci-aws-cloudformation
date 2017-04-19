#!/usr/bin/env bash

set -x

echo "docksal-startup.sh started"

# Constants expected from the instance launch configuration:
# DOCKER_HUB_AUTH
# DOCKER_HUB_EMAIL
# AWS_KEY
# AWS_SECRET
AWS_REGION="us-west-2"
# SB_IP
# PROJECT_INACTIVITY_TIMEOUT
# PROJECT_DANGLING_TIMEOUT

# Copy CI credentials
sudo mkdir /home/ubuntu/.docker
cat <<EOF > /home/ubuntu/.docker/config.json
{
    "auths": {
            "https://index.docker.io/v1/": {
                    "auth": "$DOCKER_HUB_AUTH"
            }
    }
}
EOF
# This has to be done under the ubuntu user to load Docker Hub credentials
#sudo su - ubuntu -c 'docker run --rm -v /home/ubuntu:/data ffwagency/us-east-ci'
# install & setup aws-cli
sudo apt-get install -y python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev
sudo pip install --upgrade pip
sudo pip install awscli
mkdir /home/ubuntu/.aws
touch /home/ubuntu/.aws/config && touch /home/ubuntu/.aws/credentials
echo "[default]" > /home/ubuntu/.aws/config
echo "region=$AWS_REGION" >> /home/ubuntu/.aws/config
echo /home/ubuntu/.aws/config
echo "[default]" > /home/ubuntu/.aws/credentials
echo "aws_access_key_id = $AWS_KEY" >> /home/ubuntu/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET" >> /home/ubuntu/.aws/credentials

# sync bucket "us-east-ci-sandbox-configs" with /home/ubuntu
aws s3 sync s3://us-east-ci-sandbox-configs /home/ubuntu
sudo chown -R ubuntu:ubuntu /home/ubuntu
sudo chmod 644 /home/ubuntu/.docker/config.json
sudo chmod 644 /home/ubuntu/.ssh/config
sudo chmod 644 /home/ubuntu/.ssh/id_rsa.pub
sudo chmod 600 /home/ubuntu/.ssh/id_rsa
#ssh-keygen -t rsa -N "" -f /home/ubuntu/.ssh/id_rsa

# Assign a static IP address
aws-ec2-assign-elastic-ip --region us-west-2 --access-key "$AWS_KEY" --secret-key "$AWS_SECRET" --valid-ips "$SB_IP"

# Reset docksal-ssh-agent
# This has to be done under the ubuntu user to load the ssh keys
sudo su - ubuntu -c 'fin reset ssh-agent'
# Reset docksal-vhost-proxy
fin reset proxy

echo "docksal-startup.sh finished"
