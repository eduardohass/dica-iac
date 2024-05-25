resource "aws_db_instance" "dica_database" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = "db.t2.micro" # Free Tier eligible
  db_name              = "dica"
  username             = "dica_admin"
  password             = "DicaAdmin32!#"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
  publicly_accessible  = false
  tags = {
    "managedby" = "terraform"
  }
}