# EC2 Instance Configuration Variables
variable "ec2_instance_type" {
  description = "EC2 instance type for the virtual machine"
  type        = string
  default     = "t2.micro"
}

variable "ec2_default_root_storage_size" {
  description = "Root volume size in GB for EC2 instances"
  type        = number
  default     = 10
  
  # Add validation
  validation {
    condition     = var.ec2_default_root_storage_size >= 8 && var.ec2_default_root_storage_size <= 15
    error_message = "Root storage size must be between 8 and 15 GB."
  }
}

variable "ec2_ami_id" {
  description = "AMI ID for EC2 instances (Ubuntu)"
  type        = string
  default     = "ami-0d1b5a8c13042c939"
}

# Environment Configuration
variable "env" { 
  description = "Environment name (dev, staging, prd)"
  type        = string
  default     = "dev"
  
  # Add validation for allowed values
  validation {
    condition     = contains(["dev", "staging", "prd"], var.env)
    error_message = "Environment must be dev, staging, prd."
  }
}

# AWS Configuration
variable "aws_region" {
  description = "AWS region for deploying resources"
  type        = string
  default     = "us-east-2"
}