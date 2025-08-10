#!/bin/bash

# Exit on any error
set -e

# Log all commands (useful for debugging user-data)
set -x

# Update package list
sudo apt-get update

# Install nginx
sudo apt-get install nginx -y

# Start and enable nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Create custom index.html
echo "<h1>Terraform by Arsalan</h1>" | sudo tee /var/www/html/index.html

# Ensure nginx is running
sudo systemctl status nginx --no-pager