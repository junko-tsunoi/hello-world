provider "aws" {
  region  = "ap-northeast-1"
  profile = "development"
}

#region, using the alias
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

terraform {
  required_version = "1.0.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.49.0"
    }
    template = "~> 2.2.0"
  }
}
