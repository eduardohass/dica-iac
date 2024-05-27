# resource "aws_eip" "ip-dica-vm" {
#   instance = var.spot_instance == "true" ? "${aws_spot_instance_request.dica-spot[0].spot_instance_id}" : "${aws_instance.dica-vm[0].id}"
#   domain   = "vpc"
# }

# resource "aws_spot_instance_request" "dica-spot" {
#   ami           = var.instance_ami
#   spot_price    = var.spot_price
#   instance_type = var.instance_type
#   spot_type     = var.spot_type
#   # block_duration_minutes = 120
#   wait_for_fulfillment = "true"
#   key_name             = data.aws_key_pair.devops-local.key_name
#   count                = var.spot_instance == "true" ? 1 : 0
#   tags                 = { Name = "dica-vm" }

#   security_groups = ["${aws_security_group.ingress-ssh-dica-vm.id}", "${aws_security_group.ingress-http-dica-vm.id}",
#     "${aws_security_group.ingress-https-dica-vm.id}", "${aws_security_group.ingress-pgadmin-dica-vm.id}",
#   "${aws_security_group.ingress-api-dica-vm.id}"]
#   subnet_id = aws_subnet.subnet-uno.id
# }

resource "aws_instance" "dica-vm" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.devops-local.key_name
  subnet_id                   = aws_subnet.sub-a.id
  associate_public_ip_address = true
  # vpc_security_group_ids = ["${aws_security_group.ingress-ssh-dica-vm.id}", "${aws_security_group.ingress-http-dica-vm.id}","${aws_security_group.ingress-https-dica-vm.id}"]
  security_groups = ["${aws_security_group.ingress-ssh.id}", "${aws_security_group.ingress-http.id}", "${aws_security_group.ingress-https.id}", "${aws_security_group.ingress-pgadmin.id}", "${aws_security_group.ingress-api.id}"]
  count           = var.spot_instance == "true" ? 0 : 1

  ### Install Docker
  user_data = <<-EOF
  #!/bin/bash
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo groupadd docker
  sudo usermod -aG docker ubuntu
  newgrp docker
  sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  EOF

  tags = {
    Name = "dica-vm"
  }
}