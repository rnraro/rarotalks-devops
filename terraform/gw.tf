resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_appserver.id
}