provider "aws" {
  region = "ap-northeast-1"
}

#region, using the alias
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22"
    }
    template = "~> 2.2.0"
  }
}
