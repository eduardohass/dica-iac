terraform {
  backend "remote" {
    organization = "comphass"
    workspaces {
      name = "dica-iac"
    }
  }
}
