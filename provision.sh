#!/usr/bin/env bash

echo "Installing fin and Docksal dependencies..."
sudo curl -sSL https://raw.githubusercontent.com/docksal/docksal/master/bin/fin -o /usr/local/bin/fin
sudo chmod +x /usr/local/bin/fin
fin version
fin update

echo "Installing Amazon ECS agent..."
sudo sysctl -w net.ipv4.conf.all.route_localnet=1
sudo iptables -t nat -A PREROUTING -p tcp -d 169.254.170.2 --dport 80 -j DNAT --to-destination 127.0.0.1:51679
sudo iptables -t nat -A OUTPUT -d 169.254.170.2 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 51679
sudo mkdir -p /var/log/ecs
sudo mkdir -p /var/lib/ecs/data
sudo docker run \
	--name ecs-agent \
	--detach=true \
	--restart=always \
	--volume=/var/run/docker.sock:/var/run/docker.sock \
	--volume=/var/log/ecs/:/log \
	--volume=/var/lib/ecs/data:/data \
	--net=host \
	--env=ECS_LOGFILE=/log/ecs-agent.log \
	--env=ECS_LOGLEVEL=info \
	--env=ECS_DATADIR=/data \
	--env=ECS_CLUSTER=bb-pipelines \
	--env=ECS_ENABLE_TASK_IAM_ROLE=true \
	--env=ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true \
	amazon/amazon-ecs-agent:latest

echo "Installing aws-ec2-assign-elastic-ip..."
sudo apt-get -y install python-pip </dev/null
sudo pip install aws-ec2-assign-elastic-ip

echo "Installing Git LFS client..."
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get -y install git-lfs </dev/null

echo "Setting up builds directory..."
# Symlink to EFS
# [[ ! -d /home/ubuntu/builds ]] && sudo su - ubuntu -c 'ln -s /mnt/efs/builds /home/ubuntu/builds'
# Native fs
[[ ! -d /home/ubuntu/builds ]] && sudo su - ubuntu -c 'mkdir /home/ubuntu/builds'
