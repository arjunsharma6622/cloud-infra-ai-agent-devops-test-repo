output "eks_security_group_id" {
  value       = aws_security_group.eks.id
  description = "The ID of the EKS security group"
}

output "rds_security_group_id" {
  value       = aws_security_group.rds.id
  description = "The ID of the RDS security group"
}