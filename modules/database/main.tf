resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = "db.t3.medium"
  db_name                = "appdb"
  username               = "admin"
  password               = var.db_password
  multi_az               = true
  storage_encrypted      = true
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]
  skip_final_snapshot    = true

  tags = {
    Name = "app-postgres-db"
  }
}