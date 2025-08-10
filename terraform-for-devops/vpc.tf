# VPC Module Configuration
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  # VPC Configuration
  name = "${var.env}-arsalan-vpc" # Include environment in name
  cidr = "10.0.0.0/16"

  # Availability Zones 
  azs = ["us-east-2a", "us-east-2b"]
  
  # Subnet Configuration
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Gateway Configuration
  enable_nat_gateway = true
  enable_vpn_gateway = true
  
  # Single NAT Gateway for cost optimization in dev
  single_nat_gateway = var.env == "dev" ? true : false
  
  # DNS Configuration
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tagging
  tags = {
    Name        = "${var.env}-arsalan-vpc"
    Terraform   = "true"
    Environment = var.env
    Project     = "terraform-for-devops"
  }
  
  # Subnet specific tags
  public_subnet_tags = {
    Type = "public"
    "kubernetes.io/role/elb" = "1" # For EKS integration
  }
  
  private_subnet_tags = {
    Type = "private"
    "kubernetes.io/role/internal-elb" = "1" # For EKS integration
  }
}