# Terraform Configuration Block
terraform {
  # Specify required Terraform version for consistency
  required_version = ">= 1.0"
  
  # Required providers with version constraints
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7.0" # Use ~> for patch-level flexibility
    }
  }
  
  # Remote backend configuration
  # NOTE: For learning please comment out initially and use local backend first
  # Uncomment after creating the S3 bucket and DynamoDB table in remote infra project
  backend "s3" {
    bucket         = "arsalan-state-bucket"
    key            = "terraform-for-devops/terraform.tfstate" # Add folder structure
    region         = "us-east-2"
    dynamodb_table = "arsalan-state-table"
    encrypt        = true # Enable state file encryption
  }
}

# Alternative: Local backend for initial learning (commented out the S3 backend above)
# terraform {
#   required_version = ">= 1.0"
#   
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.7.0"
#     }
#   }
# }