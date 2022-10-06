# Define a subnet
resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.vpc_appserver.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${var.aws_az}"

  tags = {
    Name = "super-subnet"
  }
}