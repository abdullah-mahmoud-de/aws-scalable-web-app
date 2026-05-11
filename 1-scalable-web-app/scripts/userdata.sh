#!/bin/bash
# Update the system
yum update -y

# Install Apache Web Server
yum install -y httpd

# Start and enable the web server to run on boot
systemctl start httpd
systemctl enable httpd

# Create a simple landing page
echo "<h1>Welcome to the Optimize-ops Highly Available Web Architecture</h1>" > /var/www/html/index.html
echo "<p>This instance was launched dynamically by AWS Auto Scaling.</p>" >> /var/www/html/index.html

# Note: The AmazonSSMManagedInstanceCore agent is pre-installed on Amazon Linux 2023 AMIs.