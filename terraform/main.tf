terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "aws" {
  region = var.region
}