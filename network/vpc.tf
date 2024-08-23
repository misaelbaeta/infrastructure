// Create VPC

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"


  name               = var.vpc_name #"sre-vpc"
  cidr               = var.vpc_cidr
  enable_nat_gateway = true
  single_nat_gateway = false
  #single_nat_gateway                 = false # for multiple nat gateways   
  propagate_private_route_tables_vgw = true
  propagate_public_route_tables_vgw  = true

  tags = {
    Name      = "sre"
    Terraform = "True"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = module.vpc.vpc_id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  # Enable auto-assign public IPs
  map_public_ip_on_launch = true
  tags = {
    Name      = "Public Subnet ${count.index + 1}"
    Terraform = "True"
    Public    = "True"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = module.vpc.vpc_id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name      = "Private Subnet ${count.index + 1}"
    Terraform = "True"
    Private   = "True"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name      = "SRE VPC IG"
    Terraform = "True"
  }
}


# NAT Gateway
resource "aws_eip" "nat-eip" {
  domain = "vpc"

  tags = {
    Name      = "nat-eip"
    Terraform = "True"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public_subnets[0].id # Assign to the first public subnet

  tags = {
    Name      = "nat-gateway"
    Terraform = "True"
  }
}

# Multiplos NAT Gateway
#resource "aws_eip" "nat-eip" {
#  count  = length(var.public_subnet_cidrs) # Create one EIP per public subnet
#  domain = "vpc"
#
#  tags = {
#    Name      = "nat-eip-${count.index + 1}"
#    Terraform = "True"
#  }
#}
#
#resource "aws_nat_gateway" "nat_gw" {
#  count         = length(var.public_subnet_cidrs) # Create one NAT gateway per public subnet
#  allocation_id = aws_eip.nat-eip[count.index].id
#  subnet_id     = aws_subnet.public_subnets[count.index].id
#
#  tags = {
#    Name      = "nat-gateway-${count.index + 1}"
#    Terraform = "True"
#  }
#}



# Route table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name      = "Public Route Table"
    Terraform = "True"
  }
}

# Route table association for Public Subnet
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Route table for Private Subnet
resource "aws_route_table" "private_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name      = "Private Route Table"
    Terraform = "True"
  }
}

# Route table association for Private Subnet
resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}


# Outputs para as subnets
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}