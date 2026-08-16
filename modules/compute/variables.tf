variable "public_subnet_ids" {
  description = "List of public subnet IDs for the Load Balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS nodes"
  type        = list(string)
}

variable "eks_security_group_id" {
  description = "Security group ID for EKS worker nodes"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "production-cluster"
}