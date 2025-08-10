# EKS Cluster Configuration
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # Cluster Configuration
  name       = local.name
  kubernetes_version = "1.30"
  
  # Network Configuration
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets
  
  # API Server Endpoint Access
  endpoint_public_access  = true
  endpoint_private_access = true
  endpoint_public_access_cidrs = ["0.0.0.0/0"] # Restrict in production
  
  # Security Group Configuration
  create_security_group = true
  security_group_tags = {
    Name = "${local.name}-cluster-sg"
  }

  # EKS Addons
  addons = {
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  # Managed Node Groups
  eks_managed_node_groups = {
    arsalan-cluster-ng = {
      instance_types = ["t2.medium"] 
      min_size       = 1
      max_size       = 3         
      desired_size   = 2
      capacity_type  = "SPOT"        
      
      # Enable detailed monitoring
      enable_monitoring = true
      
      # Tagging for node group
      tags = {
        Name = "${local.name}-node-group"
      }
    }
  }

  # Cluster wide tags
  tags = {
    Name        = local.name
    Environment = local.env
    Terraform   = "true"
    Purpose     = "learning-eks"
  }
}