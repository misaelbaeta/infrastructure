
variable "AWS_REGION" {
  default = "us-east-1"
}

#-----------------------------
# VPC
#-----------------------------

# VPC CIDR Block
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.97.32.0/19"
}


variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.97.34.0/24", "10.97.36.0/24", "10.97.38.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.97.33.0/24", "10.97.35.0/24", "10.97.37.0/24"]
}


#variable "enable_vpn_gateway" {
#  type        = bool
#  description = "Controls if a VPN Gateway should be created in the VPC"
#}

#variable "enable_nat_gateway" {
#  type        = bool
#  description = "Controls whether the NAT Gateway should be created in the VPC"
#}

#variable "single_nat_gateway" {
#  type        = bool
#  description = "Controls whether the NAT Gateway should be of single type"
#}

# N.Virginia Region
#variable "create_vpc" {
#  type        = string
#  description = "Controls if VPC should be created (it affects almost all resources)"
#}

variable "vpc_name" {
  type        = string
  description = "The VPC Name"
  default     = "sre"
}


#variable "vpc_azs_name" {
#  type        = list(string)
#  description = "A list of availability zones names or ids in the N.Virginia region"
#}

#variable "vpc_public_subnets_cidr" {
#  type        = list(string)
#  description = "A list of cidr block for public subnets in the N.Virginia region - should be include in the VPC Cidr Range"
#}

#variable "vpc_private_subnets_cidr" {
#  type        = list(string)
#  description = "A list of cidr block for private subnets in the N.Virginia region - should be include in the VPC Cidr Range"
#}

#variable "vpc_data_subnets_cidr" {
#  type        = list(string)
#  description = "A list of cidr block for data subnets in the N.Virginia region - should be include in the VPC Cidr Range"
#}

#variable "vpc_transit_subnets_cidr" {
#  type        = list(string)
#  description = "A list of cidr block for transit subnets in the N.Virginia region - should be include in the VPC Cidr Range"
#}

#variable "vpc_redis_subnets_cidr" {
#  type        = list(string)
#  description = "A list of cidr block for elasticache subnets in the N.Virginia region - should be include in the VPC Cidr Range"
#}

#variable "one_nat_gateway_per_az" {
#  type        = bool
#  description = "Should be true if you want only one NAT Gateway per availability zone."
#}

variable "enable_dns_support" {
  type        = bool
  description = "Should be true to enable DNS support in the VPC"
  default     = false
}

variable "enable_dns_hostnames" {
  type        = bool
  description = " Should be true to enable DNS hostnames in the VPC"
  default     = false
}

#---------------------------------------
# TAGS/ENVIRONMENT
#---------------------------------------
#variable "tags" {
#  description = "Tags for the project"
#  type        = map(string)
#}
#variable "environment" {
#  description = "Environment name (dev/stg/prd)"
#  type        = string
#}

variable "aws_region" {
  default = "us-east-1"
}

#-------------------------------
# VPC ENDPOINTS
#-------------------------------

variable "create_endpoint" {
  type        = bool
  description = "Controls whether a VPC endpoint should be created in the environment"
  default     = false
}