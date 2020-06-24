output "endpoint" {
  value = aws_eks_cluster.default.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.default.certificate_authority.0.data
}
output "name" {
  value = aws_eks_cluster.default.name
}