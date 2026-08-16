variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS instance"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The ID of the RDS security group"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS master user"
  type        = string
  sensitive   = true
}