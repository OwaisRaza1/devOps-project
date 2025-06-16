#🚀 DevOps Project: AWS Infrastructure Automation with Terraform
#📌 Overview
This project provides a fully automated and scalable cloud infrastructure setup using Terraform on Amazon Web Services (AWS). It provisions a multi-tier architecture that includes:
	•	A custom VPC with public/private subnets
	•	Auto Scaling Groups (ASGs) for deploying:
	•	A React web application
	•	A Business Intelligence (BI) tool using Metabase
	•	Amazon RDS instances for MySQL and PostgreSQL
	•	An Application Load Balancer (ALB) with SSL termination
	•	Route 53 DNS configuration for custom domains
	•	Dockerized deployments of both apps via EC2 user data scripts and Nginx reverse proxy
This setup is built for high availability, scalability, and follows AWS best practices, including autoscaling, SSL encryption via ACM, and modular Terraform files.

#✅ Prerequisites
Before you begin, ensure the following are in place:
	•	AWS Account: With permissions to provision VPC, EC2, RDS, ALB, ACM, and Route53 resources
	•	AWS CLI: Installed and configured on your machine
	•	Terraform (v1.0 or later): Download it from HashiCorp
	•	Registered Domain Name: Managed via Route53 with a hosted zone set up
	•	EC2 Key Pair: A valid .pem file for SSH access, referenced in terraform.tfvars


#🧱 Project Structure
Each Terraform file is modular and handles a specific part of the infrastructure:
File
Purpose
main.tf
Creates the core networking (VPC, subnets, routes, IGW)
variables.tf
Declares all input variables for easy customization
outputs.tf
Exports useful outputs like ALB DNS and DB endpoints
ec2.tf
Configures EC2 Launch Templates and ASGs with CloudWatch
alb.tf
Sets up ALB, listeners, HTTPS redirect, and rules
rds.tf
Provisions RDS MySQL and PostgreSQL instances securely
route53.tf
Manages DNS records and ACM certificate validation
security_groups.tf
Defines all required security groups
target_groups.tf
Configures ALB target groups for apps
terraform.tfvars
Provides user-specific values for deployment
Dockerfile-app
Dockerfile for building the React app container
userapp_data.sh
EC2 bootstrap script to deploy the React app
userbi_data.sh
EC2 bootstrap script to deploy Metabase BI tool

⚙️ Setup Instructions
Step 1: Configure terraform.tfvars
Customize this file with your environment details. Example:
aws_region                 = "us-west-2"
project_name               = "devops-project"
environment                = "dev"
instance_type              = "t3.micro"
key_pair_name              = "my-ec2-keypair"
domain_name                = "example.com"

# Autoscaling configs
min_size_app               = 2
desired_capacity_app       = 2
max_size_app               = 3

min_size_bi                = 1
desired_capacity_bi        = 1
max_size_bi                = 1

# RDS configs
db_username                = "admin"
db_password                = "YourStrongDBPassword!"
mysql_db_name              = "myreactdb"
postgres_db_name           = "mybidb"
db_instance_class          = "db.t3.micro"
allocated_storage          = 20
backup_retention_period    = 7
multi_az                   = false
enable_deletion_protection = false

Step 2: Initialize Terraform
terraform init
Step 3: Review Plan
terraform plan
Step 4: Deploy Infrastructure
terraform apply
Respond with yes when prompted.

Step 5: Access Applications
After deployment, Terraform will output DNS URLs:
	•	🌐 React App: https://app-owais.example.com
	•	📊 BI Tool (Metabase): https://bi-owais.example.com
⚠️ DNS propagation and ACM validation may take a few minutes after apply.

🧹 Cleanup
To destroy all provisioned AWS resources and avoid unnecessary costs:
terraform destroy
Respond with yes when prompted.

