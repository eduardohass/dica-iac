# output "ubuntu_ip" {
#   value       = aws_eip.ip-dica-vm.public_ip
#   description = "Spot intstance IP"
# }

# output "db_endpoint" {
#   value = aws_db_instance.dica_database.endpoint
# }

# output "db_dsn" {
#   value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.dica_database.endpoint}:5432/dica"
# }