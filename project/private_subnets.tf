resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.101.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private1"
  }
 }

resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.102.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private2"
  }
 }

resource "aws_subnet" "private3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.103.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private3"
  }
}