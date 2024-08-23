provider "aws" {
  region = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket = "sre-us-east-1"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
#data "aws_vpc" "sre_vpc" {
#  id = "vpc-09e5b46e3dbab2f3b" # Substitua pelo ID da sua VPC
#}

data "terraform_remote_state" "vpc" {
  backend = "s3" # ou "local", dependendo de onde você está armazenando o estado do Terraform

  config = {
    bucket = "sre-us-east-1" # substitua com o nome do seu bucket S3 ou caminho local
    key    = "network/terraform.tfstate"
    region = "us-east-1" # substitua com a região adequada
  }
}

#Changes to Outputs:
#  + private_subnet_ids = [
#      + "subnet-00f87176c02b1ec1b",
#      + "subnet-005ef65cf0d4e5eda",
#      + "subnet-0567598836fcfc69b",
#    ]
#  + public_subnet_ids  = [
#      + "subnet-0712bf931e02591ff",
#      + "subnet-0f226a3cd976a4861",
#      + "subnet-044b84eee3d66fd28",
#    ]

#output "private_subnet_ids" {
#  value = [
#    data.aws_subnet.private_subnet1.id,
#    data.aws_subnet.private_subnet2.id,
#    data.aws_subnet.private_subnet3.id
#  ]
#}

#data "aws_subnet_ids" "private_subnets" {
#  vpc_id = data.aws_vpc.sre_vpc.id
#  filter {
#    name   = "tag:Type"
#    values = ["private"]
#  }
#}