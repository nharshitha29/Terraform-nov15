resource "aws_eks_cluster" "devops_cluster" {
  name     = "devops-cluster"
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids = flatten([
      aws_subnet.public[*].id,
      aws_subnet.private[*].id
    ])
  }


  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}