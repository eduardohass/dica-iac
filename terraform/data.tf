data "aws_key_pair" "devops-local" {
  key_name           = "devops-local"
  include_public_key = true
}