resource "aws_eks_cluster" "devops_cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = flatten([
      var.public_subnet_id,
      var.private_subnet_id
    ])
  }
  
}
resource "null_resource" "web" {

  triggers = {
    build_id = var.build_id
  }

  provisioner "local-exec" {

    command = "aws eks update-kubeconfig --region ${var.aws_region.region} --name ${aws_eks_cluster.devops_cluster.name}"
  }
  depends_on = [aws_eks_cluster.devops_cluster]
}