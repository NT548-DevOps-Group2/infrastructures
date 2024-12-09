output "production-endpoint" {
  value = aws_eks_cluster.production_cluster.endpoint
}

output "test-endpoint" {
  value = aws_eks_cluster.test_cluster.endpoint
}