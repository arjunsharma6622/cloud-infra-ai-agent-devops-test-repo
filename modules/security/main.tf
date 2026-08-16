resource "aws_security_group" "eks" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-sg"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds-db-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_security_group_rule" "rds_ingress_from_eks" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eks.id
  security_group_id        = aws_security_group.rds.id
}