resource "aws_eip" "ip-dica-vm-env" {
  instance = var.spot_instance == "true" ? "${aws_spot_instance_request.dica-vm[0].spot_instance_id}" : "${aws_instance.web[0].id}"
  domain   = "vpc"
}

resource "aws_spot_instance_request" "dica-vm" {
  ami           = var.instance_ami
  spot_price    = var.spot_price
  instance_type = var.instance_type
  spot_type     = var.spot_type
  # block_duration_minutes = 120
  wait_for_fulfillment = "true"
  key_name             = data.aws_key_pair.devops-local.key_name
  count                = var.spot_instance == "true" ? 1 : 0

  security_groups = ["${aws_security_group.ingress-ssh-dica-vm.id}", "${aws_security_group.ingress-http-dica-vm.id}",
  "${aws_security_group.ingress-https-dica-vm.id}"]
  subnet_id = aws_subnet.subnet-uno.id
}

resource "aws_instance" "web" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.devops-local.key_name
  subnet_id                   = aws_subnet.subnet-uno.id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ingress-ssh-dica-vm.id}", "${aws_security_group.ingress-http-dica-vm.id}",
  "${aws_security_group.ingress-https-dica-vm.id}"]
  count = var.spot_instance == "true" ? 0 : 1
  tags = {
    Name = "dica-vm"
  }
}