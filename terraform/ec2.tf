resource "aws_eip" "ip-dica-vm-env" {
  instance = var.spot_instance == "true" ? "${aws_spot_instance_request.dica-spot[0].spot_instance_id}" : "${aws_instance.dica-vm[0].id}"
  domain   = "vpc"
}

resource "aws_spot_instance_request" "dica-spot" {
  ami           = var.instance_ami
  spot_price    = var.spot_price
  instance_type = var.instance_type
  spot_type     = var.spot_type
  # block_duration_minutes = 120
  wait_for_fulfillment = "true"
  key_name             = data.aws_key_pair.devops-local.key_name
  count                = var.spot_instance == "true" ? 1 : 0
  tags = { Name = "dica-vm" }

  security_groups = ["${aws_security_group.ingress-ssh-dica-vm.id}", "${aws_security_group.ingress-http-dica-vm.id}",
  "${aws_security_group.ingress-https-dica-vm.id}", "${aws_security_group.ingress-pgadmin-dica-vm.id}", 
  "${aws_security_group.ingress-api-dica-vm.id}"]
  subnet_id = aws_subnet.subnet-uno.id
}

resource "aws_instance" "dica-vm" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.devops-local.key_name
  subnet_id                   = aws_subnet.subnet-uno.id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ingress-ssh-dica-vm.id}", "${aws_security_group.ingress-http-dica-vm.id}",
  "${aws_security_group.ingress-https-dica-vm.id}"]
  count = var.spot_instance == "true" ? 0 : 1

  user_data = <<-EOF
    #!/bin/bash
    set -ex
    apt-get update && apt-get install -y apt-transport-https
    curl -fsSL https://get.docker.com | bash
    sudo service docker start
    sudo usermod -a -G docker $USER
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF

  tags = {
    Name = "dica-vm"
  }
}