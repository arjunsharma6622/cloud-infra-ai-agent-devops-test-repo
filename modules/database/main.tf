resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier             = "postgresql-db"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.medium"
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = "appdb"
  username               = "admin"
  password               = "ChangeMe123!"
  skip_final_snapshot    = true
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.db_security_group_id]
  storage_encrypted      = true

  tags = {
    Name = "postgresql-instance"
  }
}