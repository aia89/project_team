resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "ProjectIGW"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "ProjectRT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.r.id}"
}
resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.r.id}"
}
resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table" "n" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags = {
    Name = "ProjectRTNAT"
  }
}
#this lines below will create a nat and elastic ip
resource "aws_eip" "nat" {
  vpc  = true
}
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public1.id}"

  
   
   tags = {
    Name = "ProjectNAT"
  }
}

resource "aws_route_table_association" "d" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.n.id}"
}
resource "aws_route_table_association" "e" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.n.id}"
}
resource "aws_route_table_association" "f" {
  subnet_id      = "${aws_subnet.private3.id}"
  route_table_id = "${aws_route_table.n.id}"
}