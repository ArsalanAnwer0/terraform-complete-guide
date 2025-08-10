# Terraform configuration for EKS cluster setup
terraform {
  # Specify minimum Terraform version
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7.0" # Allow patch-level updates
    }
  }
  
  # Note: EKS clusters benefit from remote state for team collaboration
  # Consider adding backend configuration after setting up remote-infra
}