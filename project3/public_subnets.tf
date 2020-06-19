resource "aws_subnet" "public1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_cidr1}"
  # map_public_ip_on_launch = true
  # availability_zone = "us-east-1a"

  tags = {
    Name = "public1"
  }
 }

resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_cidr2}"
  # map_public_ip_on_launch = true
  # availability_zone = "us-east-1b"

  tags = {
    Name = "public2"
  }
 }

resource "aws_subnet" "public3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_cidr3}"
  # map_public_ip_on_launch = true
  # availability_zone = "us-east-1c"

  tags = {
    Name = "public3"
  }
}