output "ubuntu_ip" {
  value       = aws_eip.ip-dica-vm-env.public_ip
  description = "Spot intstance IP"
}