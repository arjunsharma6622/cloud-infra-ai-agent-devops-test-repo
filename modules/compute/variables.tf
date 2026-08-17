variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS"
  type        = list(string)
}

variable "eks_node_sg_id" {
  description = "Security group ID for EKS nodes"
  type        = string
}

variable "eks_iam_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
}