module "cluster_iam_role" {
  source           = "./module/iam"
  cluster_iam_role = "eks-cluster-example"
  node_iam_role    = "eks-node-group-example"
}
module "vpc" {
  source         = "./module/vpc"
  aws_vpc_info   = var.vpc_info
  public_subnet  = var.public_subnet_info
  private_subnet = var.private_subnet_info

}

module "primary_eks_cluster" {
  source            = "./module/eks"
  role_arn          = module.cluster_iam_role.cluster_arn
  cluster_name      = var.cluster_name
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  build_id          = var.build_id
  aws_region        = var.aws_region
  depends_on        = [module.cluster_iam_role, module.vpc]

}
module "primary_node_group" {
  source          = "./module/nodegroup"
  node_group_name = var.node_group_name
  cluster_name    = var.cluster_name
  subnet_ids      = module.vpc.public_subnet_id
  node_arn        = module.cluster_iam_role.node_arn
  desired_size    = var.desired_size
  max_size        = var.max_size
  min_size        = var.min_size
  max_unavailable = var.max_unavailable
  instance_types  = var.instance_types
  depends_on      = [module.primary_eks_cluster, module.cluster_iam_role]
}
