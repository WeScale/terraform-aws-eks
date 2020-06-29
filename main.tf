resource "aws_eks_cluster" "default" {
  name                      = var.name
  tags                      = var.tags_for_cluster
  role_arn                  = var.role
  version                   = var.version_kube
  enabled_cluster_log_types = var.enabled_cluster_log

  vpc_config {
    security_group_ids      = var.security_group_ids
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    }

  depends_on = [var.depends]
}


resource "aws_eks_node_group" "default" {
  count           = var.create ? length(var.cluster_vars) : 0
  cluster_name    = lookup(var.cluster_vars[count.index], "cluster_name", "")
  node_group_name = lookup(var.cluster_vars[count.index], "node_group_name", "")
  node_role_arn   = lookup(var.cluster_vars[count.index], "node_role_arn", "")
  scaling_config {
    desired_size = lookup(var.cluster_vars[count.index], "desired_size", "")
    max_size     = lookup(var.cluster_vars[count.index], "max_size", "")
    min_size     = lookup(var.cluster_vars[count.index], "min_size", "")
  }
  subnet_ids           = var.subnet_ids
  ami_type             = lookup(var.cluster_vars[count.index], "ami_type", "AL2_x86_64")
  disk_size            = lookup(var.cluster_vars[count.index], "disk_size", 20)
  instance_types       = var.instance_types

  labels               = var.labels[count.index]
  tags                 = var.tags_for_node_groups[count.index]
  version              = var.version_kube
  depends_on           = [var.depends_cluster]
}