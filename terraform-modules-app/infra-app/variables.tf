# Input variables for the infra app module

variable "env" {
  description = "Environment name for the infrastructure (dev, stg, prd)"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for the infrastructure application"
  type        = string 
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t2.micro, t2.small, t2.medium)"
  type        = string
}

variable "ec2_ami_id" {
  description = "AMI ID for EC2 instances (Ubuntu 20.04 LTS)"
  type        = string
}

variable "hash_key" {
  description = "Hash key for DynamoDB table"
  type        = string
}