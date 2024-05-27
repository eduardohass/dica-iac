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
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.dica-vpc.id
  availability_zone       = var.aws_availability_zone_a
  map_public_ip_on_launch = true
  tags = {
    "Name"      = "sub-a",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-b" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.dica-vpc.id
  availability_zone = var.aws_availability_zone_a
  tags = {
    "Name"      = "sub-b",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-c" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.dica-vpc.id
  availability_zone       = var.aws_availability_zone_b
  map_public_ip_on_launch = true
  tags = {
    "Name"      = "sub-c",
    "managedby" = "terraform"
  }
}

resource "aws_subnet" "sub-d" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.dica-vpc.id
  availability_zone = var.aws_availability_zone_b
  tags = {
    "Name"      = "sub-d",
    "managedby" = "terraform"
  }
}

resource "aws_route_table" "dica-vpc-rt-pub" {
  vpc_id = aws_vpc.dica-vpc.id

  # association with IGW to access the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dica-vpc-igw.id
  }

  tags = {
    "Name"      = "dica-vpc-rt-pub",
    "managedby" = "terraform"
  }
}

resource "aws_route_table" "dica-vpc-rt-priv" {
  vpc_id = aws_vpc.dica-vpc.id

  tags = {
    "Name"      = "dica-vpc-rt-priv",
    "managedby" = "terraform"
  }
}

resource "aws_route_table_association" "dica-vpc-subnet-pub-association-a" {
  subnet_id      = aws_subnet.sub-a.id
  route_table_id = aws_route_table.dica-vpc-rt-pub.id
}

resource "aws_route_table_association" "dica-vpc-subnet-pub-association-c" {
  subnet_id      = aws_subnet.sub-c.id
  route_table_id = aws_route_table.dica-vpc-rt-pub.id
}

resource "aws_route_table_association" "dica-vpc-subnet-priv-association-b" {
  subnet_id      = aws_subnet.sub-b.id
  route_table_id = aws_route_table.dica-vpc-rt-priv.id
}

resource "aws_route_table_association" "dica-vpc-subnet-priv-association-d" {
  subnet_id      = aws_subnet.sub-d.id
  route_table_id = aws_route_table.dica-vpc-rt-priv.id
}

resource "aws_internet_gateway" "dica-vpc-igw" {
  vpc_id = aws_vpc.dica-vpc.id
  tags = {
    "Name"      = "dica-vpc-igw",
    "managedby" = "terraform"
  }
}
