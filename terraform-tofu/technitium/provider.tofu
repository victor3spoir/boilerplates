terraform {
  required_providers {
    technitium = {
      source  = "kevynb/technitium"
      version = "0.4.0"
    }
  }
}

provider "technitium" {
  url                           = "http://localhost:5380"
  skip_certificate_verification = true
  token                         = var.technitium_token
}



