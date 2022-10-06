# Define a VPC
resource "aws_vpc" "vpc_appserver" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_appserver"
  }
}