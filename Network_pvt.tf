# Private Subnets
resource "aws_subnet" "private_ap_south_1a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Private Subnet ap-south-1a"
  }
}

#resource "aws_subnet" "private_ap_south_1b" {
#  vpc_id            = aws_vpc.my_vpc.id
#  cidr_block        = "10.0.4.0/24"
#  availability_zone = "ap-south-1b"
#
#  tags = {
#    Name = "Private Subnet ap-south-1b"
#  }
#}

# Create NAT GateWay

resource "aws_eip" "my_vpc_nat" {
  vpc                       = true
  associate_with_private_ip = "10.0.3.0/24"
}

resource "aws_nat_gateway" "my_vpc_natgw" {
  allocation_id = aws_eip.my_vpc_nat.id
  subnet_id     = aws_subnet.public_ap_south_1a.id

  depends_on = [
    aws_vpc.my_vpc,
    aws_internet_gateway.my_vpc_igw
  ]

  tags = {
    Name = "My VPC - NAT Gateway"
  }
}