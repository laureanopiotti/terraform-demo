#!/bin/bash
amazon-linux-extras install nginx1
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
INSTANCE_TYPE=$(curl http://169.254.169.254/latest/meta-data/instance-type)
AZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
REGION=$(curl http://169.254.169.254/latest/meta-data/placement/region)

echo """
<div style='display:flex;flex-direction:column;align-items:center;justify-content:center;'>
<h1>Deployed by Laureano :)</h1>
<img height='200' width='200' src='https://c.tenor.com/jYqfbfE5wU4AAAAM/yay-yes.gif'>
<p>Instance ID: <strong>$INSTANCE_ID</strong></p>
<p>Instance IP: <strong>$INSTANCE_IP</strong></p>
<p>Instance Type: <strong>$INSTANCE_TYPE</strong></p>
<p>Availability Zone: <strong>$AZ</strong></p>
<p>Region: <strong>$REGION</strong></p>
<div>
""" > /usr/share/nginx/html/index.html
systemctl start nginx
systemctl enable nginx

# MySQL Client
yum install -y mysql 
# Redis CLI
yum install -y gcc wget
wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make
cp src/redis-cli /usr/bin/