terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}

locals {
  cluster_name = "test-environment"
  node_group_name = "test-nodes"
  vpc_id = var.vpc_id
  subnet_ids = ["subnet-0e3cf1fc681142409", "subnet-081bb7ff75ffd8a3c", "subnet-08ba4a9cc665e9db3"]
  iam_role_arn = var.iam_role_arn
}

# EKS Cluster provisioning
resource "aws_eks_cluster" "test_cluster" {
  name     = local.cluster_name
  role_arn = local.iam_role_arn

  vpc_config {
    subnet_ids = local.subnet_ids
  }

  version = "1.29" 
}

# EKS Node Group
resource "aws_eks_node_group" "test_node_group" {
  cluster_name    = local.cluster_name
  node_group_name = local.node_group_name
  node_role_arn    = local.iam_role_arn
  subnet_ids       = local.subnet_ids

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [ aws_eks_cluster.test_cluster ]
}


# EKS Add-ons
resource "aws_eks_addon" "coredns" {
  cluster_name = local.cluster_name
  addon_name = "coredns"
  addon_version = "v1.11.1-eksbuild.4"
  depends_on = [ aws_eks_cluster.test_cluster, aws_eks_node_group.my_node_group ]
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = local.cluster_name
  addon_name = "kube-proxy"
  addon_version = "v1.29.0-eksbuild.1"
  depends_on = [ aws_eks_cluster.test_cluster ]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = local.cluster_name
  addon_name = "vpc-cni"
  addon_version = "v1.16.0-eksbuild.1"
  depends_on = [ aws_eks_cluster.test_cluster ]
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name = local.cluster_name
  addon_name = "eks-pod-identity-agent"
  addon_version = "v1.2.0-eksbuild.1"
  depends_on = [ aws_eks_cluster.test_cluster ]
}