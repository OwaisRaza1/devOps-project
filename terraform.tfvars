# AWS Configuration
aws_region = "us-west-2"

# Project Configuration
project_name = "devops-project-owais"
environment  = "dev"

# Network Configuration
# vpc_cidr               = "10.0.0.0/16"
# public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# private_subnet_cidrs   = ["10.0.10.0/24", "10.0.20.0/24"]

# EC2 Configuration
instance_type     = "t3.micro"
min_size_app          = 2
max_size_app          = 3
desired_capacity_app  = 2
min_size_bi          = 1
max_size_bi          = 1
desired_capacity_bi  = 1
key_pair_name     = "terraform-owais-key-pair"  

# Domain Configuration
domain_name = "devops42.online" 

# Database Configuration
db_username               = "owaisdb"
db_password               = "password123!"  
mysql_db_name            = "mysqlbidb"
postgres_db_name         = "psqlbidb"
db_instance_class        = "db.t3.micro"
allocated_storage        = 20
backup_retention_period  = 7
multi_az                 = false
enable_deletion_protection = false
