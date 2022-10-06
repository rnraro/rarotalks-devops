# Define a route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc_appserver.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Subnet RT"
  }
}

# Faz associação da rota com a subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public-rt.id
}