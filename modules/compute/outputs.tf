output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "lb_dns_name" {
  value = aws_lb.ingress.dns_name
}