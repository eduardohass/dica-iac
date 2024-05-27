
resource "aws_security_group" "ingress-ssh" {
  name   = "allow-ssh-sg"
  vpc_id = aws_vpc.dica-vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"      = "ingress-ssh"
    "managedby" = "terraform"
  }
}

resource "aws_security_group" "ingress-http" {
  name   = "allow-http-sg"
  vpc_id = aws_vpc.dica-vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"      = "ingress-http"
    "managedby" = "terraform"
  }
}

resource "aws_security_group" "ingress-https" {
  name   = "allow-https-sg"
  vpc_id = aws_vpc.dica-vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"      = "ingress-https"
    "managedby" = "terraform"
  }
}

resource "aws_security_group" "ingress-pgadmin" {
  name   = "allow-pgadmin-sg"
  vpc_id = aws_vpc.dica-vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 5050
    to_port   = 5050
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"      = "ingress-pgadmin"
    "managedby" = "terraform"
  }
}

resource "aws_security_group" "ingress-api" {
  name   = "allow-api-sg"
  vpc_id = aws_vpc.dica-vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"      = "ingress-api"
    "managedby" = "terraform"
  }
}

resource "aws_security_group" "ingress-rds-pg" {
  name        = "ingress-rds-pg"
  description = "Allow traffic to RDS"
  vpc_id      = aws_vpc.dica-vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Ajuste conforme necessário
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"      = "PG RDS SG"
    "managedby" = "terraform"
  }
}

