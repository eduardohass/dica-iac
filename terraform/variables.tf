variable "region" {
  type    = string
  default = "us-east-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_availability_zone_a" {
  type    = string
  default = "us-east-1a"
}
variable "aws_availability_zone_b" {
  type    = string
  default = "us-east-1b"
}
variable "instance_type" {
  type    = string
  default = "t4g.medium"
}
variable "instance_ami" {
  type        = string
  default     = "ami-03e1711813e5a07b1"
  description = "Instance AMI image to use, by default Ubuntu 20.04 LTS"
}
variable "spot_price" {
  type        = string
  default     = "0.0336"
  description = "Maximum price to pay for spot instance"
}
variable "spot_type" {
  type        = string
  default     = "persistent"
  description = "Spot instance type, this value only applies for spot instance type."
}
variable "spot_instance" {
  type        = string
  default     = "false"
  description = "This value is true if we want to use a spot instance instead of a regular one"
}
variable "db_username" {
  type    = string
  default = "dica_admin"
}
variable "db_password" {
  type    = string
  default = "DicaAdmin321!#"
}