#!/bin/bash
set -euo pipefail
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

# Update sshd_config
sed -i 's/^#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Update and install required packages
apt-get update -y
apt-get upgrade -y
apt-get install -y docker.io nginx

systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

systemctl start nginx
systemctl enable nginx

# Add 1GB Swap
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

# Create working directory
mkdir -p /opt/bi
cd /opt/bi

# Pull and run Metabase container with memory constraints
docker pull metabase/metabase:latest
docker run -d \
  --name metabase-container \
  -p 3000:3000 \
  --memory="512m" \
  -e JAVA_TOOL_OPTIONS="-Xmx256M" \
  metabase/metabase:latest

# Nginx reverse proxy for Metabase
rm -f /etc/nginx/sites-enabled/default
cat > /etc/nginx/sites-available/metabase << 'EOF'
server {
    listen 80;
    server_name bi-owais.${domain_name};

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    proxy_read_timeout 120s;
    proxy_connect_timeout 60s;
}
EOF

ln -s /etc/nginx/sites-available/metabase /etc/nginx/sites-enabled/
nginx -t && systemctl restart nginx

echo "userbi_data.sh completed at $(date)"
