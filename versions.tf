terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>6.0"
        
    }
    vault = {
        source = "hashicorp/vault"
        version = "2.17.0"
    }
  }
}