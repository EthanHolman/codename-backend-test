terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.62.0"
    }
  }
  required_version = "~> 1.0"
}

provider "aws" {
  region = "us-west-2"
}
