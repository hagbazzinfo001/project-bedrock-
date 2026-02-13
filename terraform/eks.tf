module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  # -----------------------------
  # Cluster basics
  # -----------------------------
  cluster_name    = "project-bedrock-cluster"
  cluster_version = "1.34"

  # -----------------------------
  # Networking
  # -----------------------------
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # -----------------------------
  # Security & IAM
  # -----------------------------
  enable_irsa = true

  # Modern EKS access management (VERY IMPORTANT)
  access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::079572184228:user/bedrock-admin-temp"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  # -----------------------------
  # Control Plane Logging
  # -----------------------------
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # -----------------------------
  # Managed Node Group
  # -----------------------------
  eks_managed_node_groups = {
    default = {
      name = "default-node-group"

      instance_types = ["t3.micro"]

      desired_size = 2
      min_size     = 1
      max_size     = 3

      subnet_ids = module.vpc.private_subnets

      tags = {
        Project = "Bedrock"
      }
    }
  }

  # -----------------------------
  # Global Tags
  # -----------------------------
  tags = {
    Project = "Bedrock"
  }
}

# a9125d48a483d43e7a613f8f5e0fa6b1-735342702.us-east-1.elb.amazonaws.com