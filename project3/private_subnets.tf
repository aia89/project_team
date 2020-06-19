resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnets_cidr1}"
  

  tags = {
    Name = "private1"
  }
 }

 resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnets_cidr2}"
  

  tags = {
    Name = "private2"
  }
 }

 resource "aws_subnet" "private3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnets_cidr3}"
  

  tags = {
    Name = "private3"
  }
}