output "cluster_arn" {
  value = aws_iam_role.cluster.arn
}
output "cluster_id" {
  value = aws_iam_role.cluster.id
}
output "node_arn" {
    value = aws_iam_role.node.arn
  
}
output "node_id"{
    value = aws_iam_role.node.id
}