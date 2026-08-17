output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "eks_node_sg_id" {
  value = aws_security_group.eks_node_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}