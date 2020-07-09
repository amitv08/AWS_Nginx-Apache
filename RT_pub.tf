#Create route table
resource "aws_route_table" "my_vpc_public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = {
    Name = "Public Subnets Route Table for My VPC"
  }
}

#Association of route table with public subnets
resource "aws_route_table_association" "my_vpc_ap_south_1a_public" {
  subnet_id      = aws_subnet.public_ap_south_1a.id
  route_table_id = aws_route_table.my_vpc_public.id
}

#resource "aws_route_table_association" "my_vpc_ap_south_1b_public" {
#  subnet_id      = aws_subnet.public_ap_south_1b.id
#  route_table_id = aws_route_table.my_vpc_public.id
#}