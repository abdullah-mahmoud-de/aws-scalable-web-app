variable "aws_region" {
  description = "The AWS region to deploy resources into"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project (used for tagging resources)"
  default     = "optimize-ops"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "db_username" {
  description = "Database administrator username"
  default     = "admin"
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type for the web servers"
  default     = "t2.micro" # Free-tier eligible
}