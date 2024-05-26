resource "aws_vpc" "dica-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name"      = "dica-vpc",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-a" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.dica-vpc.id
  availability_zone = var.aws_availability_zone_a
  map_public_ip_on_launch = true
  tags = {
    "Name" = "sub-a",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-b" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.dica-vpc.id
  availability_zone = var.aws_availability_zone_a
  tags = {
    "Name" = "sub-b",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-c" {
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.dica-vpc.id
  availability_zone = var.aws_availability_zone_b
  map_public_ip_on_launch = true
  tags = {
    "Name" = "sub-c",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-d" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.dica-vpc.id
  availability_zone = var.aws_availability_zone_b
  tags = {
    "Name" = "sub-d",
    "managedby" = "terraform"
  }
}

# resource "aws_security_group" "ingress-ssh-dica-vm" {
#   name   = "allow-ssh-sg"
#   vpc_id = aws_vpc.dica-vpc.id

#   ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]

#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "ingress-http-dica-vm" {
#   name   = "allow-http-sg"
#   vpc_id = aws_vpc.dica-vpc.id

#   ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]

#     from_port = 80
#     to_port   = 80
#     protocol  = "tcp"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "ingress-https-dica-vm" {
#   name   = "allow-https-sg"
#   vpc_id = aws_vpc.dica-vpc.id

#   ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]

#     from_port = 443
#     to_port   = 443
#     protocol  = "tcp"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "ingress-pgadmin-dica-vm" {
#   name   = "allow-pgadmin-sg"
#   vpc_id = aws_vpc.dica-vpc.id

#   ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]

#     from_port = 5050
#     to_port   = 5050
#     protocol  = "tcp"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "ingress-api-dica-vm" {
#   name   = "allow-api-sg"
#   vpc_id = aws_vpc.dica-vpc.id

#   ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]

#     from_port = 8080
#     to_port   = 8080
#     protocol  = "tcp"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "rds_sg" {
#   name        = "rds_sg"
#   description = "Allow traffic to RDS"
#   vpc_id      = aws_vpc.dica-vpc.id

#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Ajuste conforme necessário
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "My RDS Security Group"
#   }
# }

# resource "aws_internet_gateway" "dica-vm-gw" {
#   vpc_id = aws_vpc.dica-vpc.id
# }

# resource "aws_route_table" "route-table-dica-vm" {
#   vpc_id = aws_vpc.dica-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.dica-vm-gw.id
#   }
# }

# resource "aws_route_table_association" "subnet-association" {
#   subnet_id      = aws_subnet.subnet-uno.id
#   route_table_id = aws_route_table.route-table-dica-vm.id
# }