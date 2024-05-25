resource "aws_db_instance" "dica_database" {
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "16.1"
  identifier          = "dica_postgres_db"
  instance_class      = "db.t3.micro"
  username            = "dica_admin"
  password            = "DicaAdmin321!#"
  skip_final_snapshot = true
  storage_encrypted   = false
  publicly_accessible = true
  apply_immediately   = true
  tags = {
    "managedby" = "terraform"
  }
}