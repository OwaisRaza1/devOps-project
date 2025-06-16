variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "aws-terraform-project"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["172.31.0.0/20", "172.31.16.0/20", "172.31.48.0/20", "172.31.32.0/20"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["172.31.100.0/24", "172.31.101.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size_app" {
  description = "Minimum number of instances in App ASG"
  type        = number
  default     = 2
}

variable "desired_capacity_app" {
  description = "Desired number of instances in App ASG"
  type        = number
  default     = 2
}

variable "max_size_app" {
  description = "Maximum number of instances in App ASG"
  type        = number
  default     = 3
}

variable "min_size_bi" {
  description = "Minimum number of instances in BI ASG"
  type        = number
  default     = 1
}

variable "desired_capacity_bi" {
  description = "Desired number of instances in BI ASG"
  type        = number
  default     = 1
}

variable "max_size_bi" {
  description = "Maximum number of instances in BI ASG"
  type        = number
  default     = 1
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for EC2 instances"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "mysql_db_name" {
  description = "MySQL database name"
  type        = string
  default     = "mysqlbidb"
}

variable "postgres_db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "psqlbidb"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "backup_retention_period" {
  description = "RDS backup retention period in days"
  type        = number
  default     = 7
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for RDS"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for RDS instances"
  type        = bool
  default     = false
}
