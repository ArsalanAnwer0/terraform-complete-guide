# Local values for EKS cluster configuration
locals {
  # AWS Configuration
  region = "us-east-2"
  env    = "dev"
  
  # EKS Cluster Configuration
  name = "arsalan-eks-cluster"
  
  # VPC and Networking Configuration
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-2a", "us-east-2b"]
  
  # Subnet Configuration
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]    # For EKS worker nodes
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"] # For load balancers
  intra_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]    # For internal resources
  
  # Common tags for all resources
  tags = {
    Environment = local.env
    Project     = "terraform-eks"
    ManagedBy   = "Terraform"
  }
}