variable "region" {
  type    = string
  default = "us-east-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_availability_zone" {
  type    = string
  default = "us-east-1a"
}
variable "instance_type" {
  type    = string
  default = "t4g.medium"
}
# variable "ssh_pub_path" {
#   type        = string
#   default     = "~/.ssh/id_rsa.pub"
#   description = "Path to public key to use to login to the server"
# }
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
  default     = "one-time"
  description = "Spot instance type, this value only applies for spot instance type."
}
variable "spot_instance" {
  type        = string
  default     = "true"
  description = "This value is true if we want to use a spot instance instead of a regular one"
}