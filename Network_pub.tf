# VPC Creation
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "My VPC"
  }
}

# Public Subnets
resource "aws_subnet" "public_ap_south_1a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Public Subnet ap-south-1a"
  }
}

#resource "aws_subnet" "public_ap_south_1b" {
#  vpc_id            = aws_vpc.my_vpc.id
#  cidr_block        = "10.0.2.0/24"
#  availability_zone = "ap-south-1b"
#
#  tags = {
#    Name = "Public Subnet ap-south-1b"
#  }
#}

# Create Internet GateWay
resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My VPC - Internet Gateway"
  }
}