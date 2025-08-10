# Terraform configuration for remote infrastructure setup
terraform {
  # Specify minimum Terraform version
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7.0" # Allow patch updates
    }
  }
  
  # No backend configuration here because this folder CREATES the backend resources
  # The S3 bucket and DynamoDB table created here will be used by Terraform-for-devops and other projects
}