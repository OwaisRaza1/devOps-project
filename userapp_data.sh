#!/bin/bash

# Update sshd_config
sed -i 's/^#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Update system
apt-get update -y
apt-get upgrade -y

# Install Docker
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Install Nginx
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

# Install Git
apt-get install -y git

# Create application directory
mkdir -p /opt/app
chown ubuntu:ubuntu /opt/app

# Clone the React app repository
git clone https://github.com/Khhafeez47/reactapp.git /opt/app/reactapp
cd /opt/app/reactapp

# Write Dockerfile manually
cat > /opt/app/reactapp/Dockerfile-app << 'EOF'
${dockerfile_content}
EOF

# Build the React app Docker image
docker build -t react-app -f Dockerfile-app .

# Run the React app Docker container, mapping container port 80 to host port 8080
docker run -d -p 8080:80 --name react-app-container react-app

# Configure Nginx to reverse proxy to the React app container
cat > /etc/nginx/sites-available/reactapp << 'EOF'
server {
    listen 80;
    server_name app-owais.${domain_name};

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

# Enable Nginx site configuration
ln -s /etc/nginx/sites-available/reactapp /etc/nginx/sites-enabled/
nginx -t && systemctl restart nginx

# Log completion
echo "userapp_data.sh script completed at $(date)" >> /var/log/user-data.log
