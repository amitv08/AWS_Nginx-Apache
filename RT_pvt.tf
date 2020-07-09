#Create route table
resource "aws_route_table" "my_vpc_private" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_vpc_natgw.id
    #gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = {
    Name = "Private Subnets Route Table for My VPC"
  }
}

#Association of route table with private subnets
resource "aws_route_table_association" "my_vpc_ap_south_1a_private" {
  subnet_id      = aws_subnet.private_ap_south_1a.id
  route_table_id = aws_route_table.my_vpc_private.id
}

#resource "aws_route_table_association" "my_vpc_ap_south_1b_private" {
#  subnet_id      = aws_subnet.private_ap_south_1b.id
#  route_table_id = aws_route_table.my_vpc_private.id
#}