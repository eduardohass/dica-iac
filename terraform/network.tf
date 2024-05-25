resource "aws_vpc" "dica-vm-env" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet-uno" {
  # creates a subnet
  cidr_block        = cidrsubnet(aws_vpc.dica-vm-env.cidr_block, 3, 1)
  vpc_id            = aws_vpc.dica-vm-env.id
  availability_zone = var.aws_availability_zone
}

resource "aws_security_group" "ingress-ssh-dica-vm" {
  name   = "allow-ssh-sg"
  vpc_id = aws_vpc.dica-vm-env.id

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
}

resource "aws_security_group" "ingress-http-dica-vm" {
  name   = "allow-http-sg"
  vpc_id = aws_vpc.dica-vm-env.id

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
}

resource "aws_security_group" "ingress-https-dica-vm" {
  name   = "allow-https-sg"
  vpc_id = aws_vpc.dica-vm-env.id

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
}

resource "aws_security_group" "ingress-pgadmin-dica-vm" {
  name   = "allow-pgadmin-sg"
  vpc_id = aws_vpc.dica-vm-env.id

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
}

resource "aws_security_group" "ingress-api-dica-vm" {
  name   = "allow-api-sg"
  vpc_id = aws_vpc.dica-vm-env.id

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
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow traffic to RDS"
  vpc_id      = aws_vpc.dica-vm-env.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Ajuste conforme necessário
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My RDS Security Group"
  }
}

resource "aws_internet_gateway" "dica-vm-env-gw" {
  vpc_id = aws_vpc.dica-vm-env.id
}

resource "aws_route_table" "route-table-dica-vm-env" {
  vpc_id = aws_vpc.dica-vm-env.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dica-vm-env-gw.id
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-dica-vm-env.id
}