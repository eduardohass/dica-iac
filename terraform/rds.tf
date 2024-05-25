resource "aws_db_instance" "dica_database" {
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "16.1"
  identifier          = "dica"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  storage_encrypted   = false
  publicly_accessible = true
  apply_immediately   = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags = {
    "Name"  = "dica"
    "managedby" = "terraform"
  }
}