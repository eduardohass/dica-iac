resource "aws_db_instance" "dica_database" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "16.1"
  identifier             = "dica"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  storage_encrypted      = false
  publicly_accessible    = true
  apply_immediately      = true
  vpc_security_group_ids = [aws_security_group.ingress-rds-pg.id]
  db_subnet_group_name   = aws_db_subnet_group.dica_rds_subnet_group.name
  depends_on             = [aws_db_subnet_group.dica_rds_subnet_group]
  tags = {
    "Name"      = "dica"
    "managedby" = "terraform"
  }
}

resource "aws_db_subnet_group" "dica_rds_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.sub-a.id, aws_subnet.sub-c.id]

  tags = {
    Name        = "Dica RDS Postgres Subnet Group"
    "managedby" = "terraform"
  }
}

# Criação do novo banco de dados no RDS
resource "null_resource" "dica" {
  provisioner "local-exec" {
    command = <<EOT
      cat /etc/os-release
      apt-get update && apt install postgresql postgresql-contrib -y
      PGPASSWORD=${var.db_password} psql -h ${aws_db_instance.dica_database.endpoint} -U ${aws_db_instance.dica_database.username} -d postgres -c "CREATE DATABASE dica;"
    EOT
    environment = {
      PGPASSWORD = var.db_password
    }
  }

  depends_on = [
    aws_db_instance.dica_database
  ]
}