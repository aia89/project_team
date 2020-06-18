resource "aws_instance" "centos"{
    ami = "ami-0affd4508a5d2481b"
    instance_type = "t3.medium"
    key_name = "${aws_key_pair.deployer.key_name}"
  security_groups = ["${aws_security_group.allow_tls.name}"]
   user_data = "${file("nagios.sh")}"
		# #! /bin/bash
        #         sudo yum install epel-release -y
		#       sudo yum install curl -y
		#          sudo curl  https://assets.nagios.com/downloads/nagiosxi/install.sh | sh
		# 		EOF
				tags = {
		Name = "NagiosXI"	
 }


}
     resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
 

}

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

  tags = {
    Name = "allow_tls"
  }
}