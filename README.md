# final version project 4, ready for provisioning.

1. Provisioner.tf 
Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.


#this part we be creating a key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
 }
 
resource "aws_instance" "centos" {
  ami               = "${data.aws_ami.centos.id}"
  key_name          = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  subnet_id         = "${aws_subnet.public1.id}"
  associate_public_ip_address = true
  source_dest_check = false
#this part runs a user data from nagios.sh file in order to install prerequisites for nagios server.
  user_data = "${file("nagios.sh")}"
  instance_type = "t3.medium"
 
 #the name of the project
 tags = {
    Name = "NagiosProject"
  }
 }

#security groups 
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 5693
    to_port     = 5693
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "allow_tls"
  }
}


2. aws_vpc provides details about a specific VPC.

This resource can prove useful when a module accepts a vpc id as an input variable and needs to, for example, determine the CIDR block of that VPC.


resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
}
tags = {
    Name = "ProjectVPC"
  }
}

3.private and public subnets
aws_subnet provides details about a specific VPC subnet.

This resource can prove useful when a module accepts a subnet id as an input variable and needs to, for example, determine the id of the VPC that the subnet belongs to.

4.networking.tf


