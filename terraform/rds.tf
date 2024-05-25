resource "aws_db_instance" "dica_database" {
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "11.5"
  identifier          = "dica-postgres-db"
  instance_class      = "db.t2.micro"
  username            = "dica-admin"
  password            = "DicaAdmin321!#"
  skip_final_snapshot = true
  storage_encrypted   = false
  publicly_accessible = true
  apply_immediately   = true
  tags = {
    "managedby" = "terraform"
  }
}