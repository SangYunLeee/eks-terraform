locals {
  cluster_name = "eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = local.cluster_name
  cluster_version = "1.27"

  vpc_id                         = data.aws_vpc.selected.id
  subnet_ids                     = data.aws_subnets.private.ids
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t2.small"]

      min_size     = 0
      max_size     = 3
      desired_size = 0
    }

    two = {
      name = "node-group-2"

      instance_types = ["t2.small"]

      min_size     = 0
      max_size     = 2
      desired_size = 0
    }
  }
}
