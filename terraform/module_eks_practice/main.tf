module "cluster_iam_role" {
  source           = "./module/iam"
  cluster_iam_role = "eks-cluster-example"
  node_iam_role    = "eks-node-group-example"
}
module "vpc" {
  source = "./module/vpc"
  aws_vpc_info = {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Env"  = "dev"
      "Name" = "web_vpc"
    }
  }
  public_subnet = [{
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      "Name" = "web-1"
      "Env"  = "dev"
    }
    },
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1b"
      tags = {
        "Name" = "web-2"
        "Env"  = "dev"
      }
  }]

  private_subnet = [{
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      "Name" = "app-1"
      "Env"  = "dev"
    }
    },
    {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1b"
      tags = {
        "Name" = "app-2"
        "Env"  = "dev"
      }
  }]


}

module "primary_eks_cluster" {
  source            = "./module/eks"
  role_arn          = module.cluster_iam_role.cluster_arn
  cluster_name      = "first-cluster"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  build_id = 1
  aws_region = var.aws_region
  depends_on = [ module.cluster_iam_role,module.vpc ]

}
module "primary_node_group" {
  source          = "./module/nodegroup"
  node_group_name = "first-nodegroup"
  cluster_name    = "first-cluster"
  subnet_ids      = module.vpc.public_subnet_id
  node_arn        = module.cluster_iam_role.node_arn
  desired_size    = 2
  max_size        = 3
  min_size        = 2
  max_unavailable = 1
  instance_types  = "t3.small"
  depends_on = [ module.primary_eks_cluster,module.cluster_iam_role ]
}
