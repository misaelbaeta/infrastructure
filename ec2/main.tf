provider "aws" {
  region = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket = "sre-us-east-1"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3" # ou "local", dependendo de onde você está armazenando o estado do Terraform

  config = {
    bucket = "sre-us-east-1" # substitua com o nome do seu bucket S3 ou caminho local
    key    = "network/terraform.tfstate"
    region = "us-east-1" # substitua com a região adequada
  }
}


