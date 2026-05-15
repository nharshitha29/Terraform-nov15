variable "cluster_iam_role" {
    type = string
    default = "eks-cluster-example"
  
}
variable "node_iam_role" {
    type = string
    default = "eks-node-group-example"
  
}